import Models
import ReactiveCocoa
import ReactiveExtensions
import Alamofire

/**
 A `ServerType` that requests data from an API webservice.
*/
public struct Service : ServiceType {
  public static let shared = Service()

  public let serverConfig: ServerConfigType
  public let oauthToken: OauthTokenAuthType?
  public let language: String

  private init() {
    self.serverConfig = ServerConfig.production
    self.oauthToken = nil
    self.language = "en"
  }

  public init(serverConfig: ServerConfigType, oauthToken: OauthTokenAuthType?, language: String) {
    self.serverConfig = serverConfig
    self.oauthToken = oauthToken
    self.language = language
  }

  public func fetchDiscovery(params: DiscoveryParams) -> SignalProducer<DiscoveryEnvelope, ErrorEnvelope> {
    return request(.Discover(params))
      .decodeModel(DiscoveryEnvelope.self)
  }

  public func fetchProjects(params: DiscoveryParams) -> SignalProducer<[Project], ErrorEnvelope> {
    return fetchDiscovery(params)
      .map { env in env.projects }
  }

  public func fetchProject(params: DiscoveryParams) -> SignalProducer<Project, ErrorEnvelope> {
    return request(.Discover(params.with(perPage: 1)))
      .decodeModel(DiscoveryEnvelope.self)
      .flatMap { envelope in envelope.projects.first }
  }

  public func fetchProject(project: Project) -> SignalProducer<Project, ErrorEnvelope> {
    return request(.Project(project))
      .decodeModel(Project.self)
  }

  public func fetchUserSelf() -> SignalProducer<User, ErrorEnvelope> {
    return request(.UserSelf)
      .decodeModel(User.self)
  }

  public func fetchUser(user: User) -> SignalProducer<User, ErrorEnvelope> {
    return request(.User(user))
      .decodeModel(User.self)
  }

  public func fetchCategories() -> SignalProducer<[Models.Category], ErrorEnvelope> {
    return request(.Categories)
      .decodeModel(CategoriesEnvelope.self)
      .map { envelope in envelope.categories }
  }

  public func fetchCategory(category: Models.Category) -> SignalProducer<Models.Category, ErrorEnvelope> {
    return request(.Category(category))
      .decodeModel(Models.Category.self)
  }

  public func toggleStar(project: Project) -> SignalProducer<Project, ErrorEnvelope> {
    return request(.ToggleStar(project))
      .decodeModel(StarEnvelope.self)
      .map { envelope in envelope.project }
  }

  public func star(project: Project) -> SignalProducer<Project, ErrorEnvelope> {
    return request(.Star(project))
      .decodeModel(StarEnvelope.self)
      .map { envelope in envelope.project }
  }

  public func login(email email: String, password: String) -> SignalProducer<AccessTokenEnvelope, ErrorEnvelope> {
    return request(.Login(email: email, password: password))
      .decodeModel(AccessTokenEnvelope.self)
  }

  private func request(route: Route) -> Alamofire.Request {
    return Alamofire.request(self.requestFromRoute(route))
      .validate(statusCode: 200..<300)
      .validate(contentType: ["application/json"])
  }

  /**
   Converts a `Route` into a URL request that can be used with Alamofire.
  */
  private func requestFromRoute(route: Route) -> URLRequestConvertible {
    let properties = route.requestProperties

    let URL = self.serverConfig.apiBaseUrl.URLByAppendingPathComponent(properties.path)
    let request = NSMutableURLRequest(URL: URL)
    request.HTTPMethod = properties.method.rawValue

    // Add some query params for authentication et al
    var query = properties.query
    query["client_id"] = self.serverConfig.apiClientAuth.clientId
    if let token = self.oauthToken?.token {
      query["oauth_token"] = token
    }

    // Add some headers
    var headers = request.allHTTPHeaderFields ?? [:]
    if let authHeader = self.serverConfig.basicHTTPAuth?.authorizationHeader {
      headers["Authorization"] = authHeader
    }
    headers["Accept-Language"] = self.language
    headers["Kickstarter-iOS-App"] = "9999" // TODO: make this a dependency
    request.allHTTPHeaderFields = headers

    let (retRequest, _) = Alamofire.ParameterEncoding.URL.encode(request, parameters: query)

    return retRequest
  }
}
