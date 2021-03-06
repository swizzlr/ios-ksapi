import Argo
import Curry
import Prelude

public struct DiscoveryParams {
  public let backed: Bool?
  public let category: Category?
  public let collaborated: Bool?
  public let created: Bool?
  public let hasVideo: Bool?
  public let includePOTD: Bool?
  public let page: Int?
  public let perPage: Int?
  public let query: String?
  public let recommended: Bool?
  public let seed: Int?
  public let similarTo: Project?
  public let social: Bool?
  public let sort: Sort?
  public let staffPicks: Bool?
  public let starred: Bool?
  public let state: State?

  public enum State: String, Decodable {
    case all
    case live
    case successful
  }

  public enum Sort: String, Decodable {
    case endingSoon = "end_date"
    case magic
    case mostFunded = "most_funded"
    case newest
    case popular = "popularity"
  }

  public static let defaults = DiscoveryParams(backed: nil, category: nil, collaborated: nil, created: nil,
                                               hasVideo: nil, includePOTD: nil, page: nil, perPage: nil,
                                               query: nil, recommended: nil, seed: nil, similarTo: nil,
                                               social: nil, sort: nil, staffPicks: nil, starred: nil,
                                               state: nil)

  public var queryParams: [String:String] {
    var params: [String:String] = [:]
    params["backed"] = self.backed == true ? "1" : self.backed == false ? "-1" : nil
    params["category_id"] = self.category?.id.description
    params["collaborated"] = self.collaborated?.description
    params["created"] = self.created?.description
    params["has_video"] = self.hasVideo?.description
    params["page"] = self.page?.description
    params["per_page"] = self.perPage?.description
    params["recommended"] = self.recommended?.description
    params["seed"] = self.seed?.description
    params["similar_to"] = self.similarTo?.id.description
    params["social"] = self.social == true ? "1" : self.social == false ? "-1" : nil
    params["sort"] = self.sort?.rawValue
    params["staff_picks"] = self.staffPicks?.description
    params["starred"] = self.starred == true ? "1" : self.starred == false ? "-1" : nil
    params["state"] = self.state?.rawValue
    params["term"] = self.query

    // Include the POTD only when searching when sorting by magic / not specifying sort
    if params["sort"] == nil || params["sort"] == DiscoveryParams.Sort.magic.rawValue {
      params["include_potd"] = self.includePOTD?.description
    }

    return params
  }
}

extension DiscoveryParams: Equatable {}
public func == (a: DiscoveryParams, b: DiscoveryParams) -> Bool {
  return a.queryParams == b.queryParams
}

extension DiscoveryParams: Hashable {
  public var hashValue: Int {
    return self.description.hash
  }
}

extension DiscoveryParams: CustomStringConvertible, CustomDebugStringConvertible {
  public var description: String {
    return self.queryParams.description
  }

  public var debugDescription: String {
    return self.queryParams.debugDescription
  }
}

extension DiscoveryParams: Decodable {
  public static func decode(json: JSON) -> Decoded<DiscoveryParams> {
    let create = curry(DiscoveryParams.init)
    let tmp1 = create
      <^> (json <|? "backed" >>- stringIntToBool)
      <*> json <|? "category"
      <*> (json <|? "collaborated" >>- stringToBool)
      <*> (json <|? "created" >>- stringToBool)
      <*> (json <|? "has_video" >>- stringToBool)
      <*> (json <|? "include_potd" >>- stringToBool)
    let tmp2 = tmp1
      <*> (json <|? "page" >>- stringToInt)
      <*> (json <|? "per_page" >>- stringToInt)
      <*> json <|? "term"
      <*> (json <|? "recommended" >>- stringToBool)
      <*> (json <|? "seed" >>- stringToInt)
      <*> json <|? "similar_to"
    return tmp2
      <*> (json <|? "social" >>- stringIntToBool)
      <*> json <|? "sort"
      <*> (json <|? "staff_picks" >>- stringToBool)
      <*> (json <|? "starred" >>- stringIntToBool)
      <*> json <|? "state"
  }
}

private func stringToBool(string: String?) -> Decoded<Bool?> {
  guard let string = string else { return .Success(nil) }
  switch string {
  // taken from server's `value_to_boolean` function
  case "true", "1", "t", "T", "true", "TRUE", "on", "ON":
    return .Success(true)
  case "false", "0", "f", "F", "false", "FALSE", "off", "OFF":
    return .Success(false)
  default:
    return .Failure(.Custom("Could not parse string into bool."))
  }
}

private func stringToInt(string: String?) -> Decoded<Int?> {
  guard let string = string else { return .Success(nil) }
  return Int(string).map(Decoded.Success) ?? .Failure(.Custom("Could not parse string into int."))
}

private func stringIntToBool(string: String?) -> Decoded<Bool?> {
  guard let string = string else { return .Success(nil) }
  return Int(string)
    .filter { $0 <= 1 && $0 >= -1 }
    .map { .Success($0 == 0 ? nil : $0 == 1) }
    ?? .Failure(.Custom("Could not parse string into bool."))
}
