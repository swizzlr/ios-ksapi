// swiftlint:disable file_length
// swiftlint:disable type_body_length
// swiftlint:disable function_body_length
import ReactiveCocoa
import Prelude

internal struct MockService: ServiceType {
  internal let appId: String
  internal let serverConfig: ServerConfigType
  internal let oauthToken: OauthTokenAuthType?
  internal let language: String
  internal let buildVersion: String

  private let changePaymentMethodResponse: ChangePaymentMethodEnvelope

  private let createPledgeResponse: CreatePledgeEnvelope

  private let facebookConnectResponse: User?
  private let facebookConnectError: ErrorEnvelope?

  private let fetchActivitiesResponse: [Activity]?
  private let fetchActivitiesError: ErrorEnvelope?

  private let fetchBackingResponse: Backing

  private let fetchCategoriesResponse: CategoriesEnvelope?

  private let fetchCheckoutResponse: CheckoutEnvelope?
  private let fetchCheckoutError: ErrorEnvelope?

  private let fetchCommentsResponse: [Comment]?
  private let fetchCommentsError: ErrorEnvelope?

  private let fetchConfigResponse: Config?

  private let fetchDiscoveryResponse: DiscoveryEnvelope?
  private let fetchDiscoveryError: ErrorEnvelope?

  private let fetchFriendsResponse: FindFriendsEnvelope?
  private let fetchFriendsError: ErrorEnvelope?

  private let fetchFriendStatsResponse: FriendStatsEnvelope?
  private let fetchFriendStatsError: ErrorEnvelope?

  private let fetchDraftResponse: UpdateDraft?
  private let fetchDraftError: ErrorEnvelope?

  private let addAttachmentResponse: UpdateDraft.Image?
  private let addAttachmentError: ErrorEnvelope?
  private let removeAttachmentResponse: UpdateDraft.Image?
  private let removeAttachmentError: ErrorEnvelope?

  private let publishUpdateError: ErrorEnvelope?

  private let fetchMessageThreadResponse: MessageThread
  private let fetchMessageThreadsResponse: [MessageThread]

  private let fetchProjectResponse: Project?

  private let fetchProjectNotificationsResponse: [ProjectNotification]

  private let fetchProjectsResponse: [Project]?
  private let fetchProjectsError: ErrorEnvelope?

  private let fetchProjectStatsResponse: ProjectStatsEnvelope?
  private let fetchProjectStatsError: ErrorEnvelope?

  private let fetchShippingRulesResponse: [ShippingRule]

  private let fetchSurveyResponseResponse: SurveyResponse?
  private let fetchSurveyResponseError: ErrorEnvelope?

  private let fetchUnansweredSurveyResponsesResponse: [SurveyResponse]

  private let fetchUpdateResponse: Update

  private let fetchUserProjectsBackedResponse: [Project]?
  private let fetchUserProjectsBackedError: ErrorEnvelope?

  private let fetchUserResponse: User?
  private let fetchUserError: ErrorEnvelope?

  private let fetchUserSelfResponse: User?
  private let fetchUserSelfError: ErrorEnvelope?

  private let followFriendError: ErrorEnvelope?

  private let incrementVideoCompletionError: ErrorEnvelope?

  private let incrementVideoStartError: ErrorEnvelope?

  private let postCommentResponse: Comment?
  private let postCommentError: ErrorEnvelope?

  private let fetchProjectActivitiesResponse: [Activity]?
  private let fetchProjectActivitiesError: ErrorEnvelope?

  private let loginResponse: AccessTokenEnvelope?
  private let loginError: ErrorEnvelope?
  private let resendCodeResponse: ErrorEnvelope?
  private let resendCodeError: ErrorEnvelope?

  private let resetPasswordResponse: User?
  private let resetPasswordError: ErrorEnvelope?

  private let signupResponse: AccessTokenEnvelope?
  private let signupError: ErrorEnvelope?

  private let submitApplePayResponse: SubmitApplePayEnvelope

  private let toggleStarResponse: StarEnvelope?

  private let unfollowFriendError: ErrorEnvelope?

  private let updateDraftError: ErrorEnvelope?

  private let updatePledgeResponse: UpdatePledgeEnvelope

  private let updateProjectNotificationResponse: ProjectNotification?
  private let updateProjectNotificationError: ErrorEnvelope?

  private let updateUserSelfError: ErrorEnvelope?

  internal init(appId: String = "com.kickstarter.kickstarter.mock",
                serverConfig: ServerConfigType,
                oauthToken: OauthTokenAuthType?,
                language: String,
                buildVersion: String = "1") {

    self.init(
      appId: appId,
      serverConfig: serverConfig,
      oauthToken: oauthToken,
      language: language,
      buildVersion: buildVersion,
      fetchActivitiesResponse: nil
    )
  }

  internal init(appId: String = "com.kickstarter.kickstarter.mock",
                serverConfig: ServerConfigType = ServerConfig.production,
                oauthToken: OauthTokenAuthType? = nil,
                language: String = "en",
                buildVersion: String = "1",
                changePaymentMethodResponse: ChangePaymentMethodEnvelope = .template,
                createPledgeResponse: CreatePledgeEnvelope = .template,
                facebookConnectResponse: User? = nil,
                facebookConnectError: ErrorEnvelope? = nil,
                fetchActivitiesResponse: [Activity]? = nil,
                fetchActivitiesError: ErrorEnvelope? = nil,
                fetchBackingResponse: Backing = .template,
                fetchCategoriesResponse: CategoriesEnvelope? = nil,
                fetchCheckoutResponse: CheckoutEnvelope? = nil,
                fetchCheckoutError: ErrorEnvelope? = nil,
                fetchCommentsResponse: [Comment]? = nil,
                fetchCommentsError: ErrorEnvelope? = nil,
                fetchConfigResponse: Config? = nil,
                fetchDiscoveryResponse: DiscoveryEnvelope? = nil,
                fetchDiscoveryError: ErrorEnvelope? = nil,
                fetchFriendsResponse: FindFriendsEnvelope? = nil,
                fetchFriendsError: ErrorEnvelope? = nil,
                fetchFriendStatsResponse: FriendStatsEnvelope? = nil,
                fetchFriendStatsError: ErrorEnvelope? = nil,
                fetchDraftResponse: UpdateDraft? = nil,
                fetchDraftError: ErrorEnvelope? = nil,
                addAttachmentResponse: UpdateDraft.Image? = nil,
                addAttachmentError: ErrorEnvelope? = nil,
                removeAttachmentResponse: UpdateDraft.Image? = nil,
                removeAttachmentError: ErrorEnvelope? = nil,
                publishUpdateError: ErrorEnvelope? = nil,
                fetchMessageThreadResponse: MessageThread? = nil,
                fetchMessageThreadsResponse: [MessageThread]? = nil,
                fetchProjectActivitiesResponse: [Activity]? = nil,
                fetchProjectActivitiesError: ErrorEnvelope? = nil,
                fetchProjectResponse: Project? = nil,
                fetchProjectNotificationsResponse: [ProjectNotification]? = nil,
                fetchProjectsResponse: [Project]? = nil,
                fetchProjectsError: ErrorEnvelope? = nil,
                fetchProjectStatsResponse: ProjectStatsEnvelope? = nil,
                fetchProjectStatsError: ErrorEnvelope? = nil,
                fetchShippingRulesResponse: [ShippingRule] = [],
                fetchUserProjectsBackedResponse: [Project]? = nil,
                fetchUserProjectsBackedError: ErrorEnvelope? = nil,
                fetchUserResponse: User? = nil,
                fetchUserError: ErrorEnvelope? = nil,
                fetchUserSelfResponse: User? = nil,
                followFriendError: ErrorEnvelope? = nil,
                incrementVideoCompletionError: ErrorEnvelope? = nil,
                incrementVideoStartError: ErrorEnvelope? = nil,
                fetchSurveyResponseResponse: SurveyResponse? = nil,
                fetchSurveyResponseError: ErrorEnvelope? = nil,
                fetchUnansweredSurveyResponsesResponse: [SurveyResponse] = [],
                fetchUpdateResponse: Update = .template,
                fetchUserSelfError: ErrorEnvelope? = nil,
                postCommentResponse: Comment? = nil,
                postCommentError: ErrorEnvelope? = nil,
                loginResponse: AccessTokenEnvelope? = nil,
                loginError: ErrorEnvelope? = nil,
                resendCodeResponse: ErrorEnvelope? = nil,
                resendCodeError: ErrorEnvelope? = nil,
                resetPasswordResponse: User? = nil,
                resetPasswordError: ErrorEnvelope? = nil,
                signupResponse: AccessTokenEnvelope? = nil,
                signupError: ErrorEnvelope? = nil,
                submitApplePayResponse: SubmitApplePayEnvelope = .template,
                toggleStarResponse: StarEnvelope? = nil,
                unfollowFriendError: ErrorEnvelope? = nil,
                updateDraftError: ErrorEnvelope? = nil,
                updatePledgeResponse: UpdatePledgeEnvelope? = nil,
                updateProjectNotificationResponse: ProjectNotification? = nil,
                updateProjectNotificationError: ErrorEnvelope? = nil,
                updateUserSelfError: ErrorEnvelope? = nil) {

    self.appId = appId
    self.serverConfig = serverConfig
    self.oauthToken = oauthToken
    self.language = language
    self.buildVersion = buildVersion

    self.changePaymentMethodResponse = changePaymentMethodResponse
    self.createPledgeResponse = createPledgeResponse

    self.facebookConnectResponse = facebookConnectResponse
    self.facebookConnectError = facebookConnectError

    self.fetchActivitiesResponse = fetchActivitiesResponse ?? [
      .template,
      .template |> Activity.lens.category .~ .backing,
      .template |> Activity.lens.category .~ .success
    ]

    self.fetchActivitiesError = fetchActivitiesError

    self.fetchBackingResponse = fetchBackingResponse

    self.fetchCategoriesResponse = fetchCategoriesResponse ?? (.template
      |> CategoriesEnvelope.lens.categories .~ [
        .art,
        .filmAndVideo,
        .illustration,
        .documentary
      ]
    )

    self.fetchCheckoutResponse = fetchCheckoutResponse
    self.fetchCheckoutError = fetchCheckoutError

    self.fetchCommentsResponse = fetchCommentsResponse ?? [
      .template |> Comment.lens.id .~ 2,
      .template |> Comment.lens.id .~ 1
    ]

    self.fetchCommentsError = fetchCommentsError

    self.fetchConfigResponse = fetchConfigResponse ?? .template

    self.fetchDiscoveryResponse = fetchDiscoveryResponse
    self.fetchDiscoveryError = fetchDiscoveryError

    self.fetchFriendsResponse = fetchFriendsResponse
    self.fetchFriendsError = fetchFriendsError

    self.fetchFriendStatsResponse = fetchFriendStatsResponse
    self.fetchFriendStatsError = fetchFriendStatsError

    self.fetchDraftResponse = fetchDraftResponse
    self.fetchDraftError = fetchDraftError

    self.addAttachmentResponse = addAttachmentResponse
    self.addAttachmentError = addAttachmentError
    self.removeAttachmentResponse = removeAttachmentResponse
    self.removeAttachmentError = removeAttachmentError

    self.publishUpdateError = publishUpdateError

    self.fetchMessageThreadResponse = fetchMessageThreadResponse ?? .template

    self.fetchMessageThreadsResponse = fetchMessageThreadsResponse ?? [
      .template |> MessageThread.lens.id .~ 1,
      .template |> MessageThread.lens.id .~ 2,
      .template |> MessageThread.lens.id .~ 3
    ]

    self.fetchProjectActivitiesResponse = fetchProjectActivitiesResponse ?? [
      .template,
      .template |> Activity.lens.category .~ .backing,
      .template |> Activity.lens.category .~ .commentProject
      ]
      .enumerate()
      .map(Activity.lens.id.set)

    self.fetchProjectActivitiesError = fetchProjectActivitiesError

    self.fetchProjectResponse = fetchProjectResponse

    self.fetchProjectNotificationsResponse = fetchProjectNotificationsResponse ?? [
      .template |> ProjectNotification.lens.id .~ 1,
      .template |> ProjectNotification.lens.id .~ 2,
      .template |> ProjectNotification.lens.id .~ 3
    ]

    self.fetchProjectsResponse = fetchProjectsResponse ?? []

    self.fetchProjectsError = fetchProjectsError

    self.fetchProjectStatsResponse = fetchProjectStatsResponse
    self.fetchProjectStatsError = fetchProjectStatsError

    self.fetchShippingRulesResponse = fetchShippingRulesResponse

    self.fetchSurveyResponseResponse = fetchSurveyResponseResponse
    self.fetchSurveyResponseError = fetchSurveyResponseError

    self.fetchUnansweredSurveyResponsesResponse = fetchUnansweredSurveyResponsesResponse

    self.fetchUpdateResponse = fetchUpdateResponse

    self.fetchUserProjectsBackedResponse = fetchUserProjectsBackedResponse
    self.fetchUserProjectsBackedError = fetchUserProjectsBackedError

    self.fetchUserResponse = fetchUserResponse
    self.fetchUserError = fetchUserError

    self.fetchUserSelfResponse = fetchUserSelfResponse ?? .template
    self.fetchUserSelfError = fetchUserSelfError

    self.followFriendError = followFriendError

    self.incrementVideoCompletionError = incrementVideoCompletionError

    self.incrementVideoStartError = incrementVideoStartError

    self.postCommentResponse = postCommentResponse ?? .template

    self.postCommentError = postCommentError

    self.loginResponse = loginResponse

    self.loginError = loginError

    self.resendCodeResponse = resendCodeResponse

    self.resendCodeError = resendCodeError

    self.resetPasswordResponse = resetPasswordResponse

    self.resetPasswordError = resetPasswordError

    self.signupResponse = signupResponse

    self.signupError = signupError

    self.submitApplePayResponse = submitApplePayResponse

    self.toggleStarResponse = toggleStarResponse

    self.unfollowFriendError = unfollowFriendError

    self.updateDraftError = updateDraftError

    self.updatePledgeResponse = updatePledgeResponse ?? .template

    self.updateProjectNotificationResponse = updateProjectNotificationResponse

    self.updateProjectNotificationError = updateProjectNotificationError

    self.updateUserSelfError = updateUserSelfError
  }

  internal func createPledge(project project: Project,
                             amount: Double,
                             reward: Reward?,
                             shippingLocation: Location?,
                             tappedReward: Bool) -> SignalProducer<CreatePledgeEnvelope, ErrorEnvelope> {

    return SignalProducer(value: .template)
  }

  internal func facebookConnect(facebookAccessToken token: String)
    -> SignalProducer<User, ErrorEnvelope> {

      if let response = facebookConnectResponse {
        return SignalProducer(value: response)
      } else if let error = facebookConnectError {
        return SignalProducer(error: error)
      }

      return SignalProducer(value:
        .template
          |> User.lens.id .~ 1
          |> User.lens.facebookConnected .~ true
      )
  }

  internal func fetchCheckout(checkoutUrl url: String) -> SignalProducer<CheckoutEnvelope, ErrorEnvelope> {
    if let response = fetchCheckoutResponse {
      return SignalProducer(value: response)
    } else if let error = fetchCheckoutError {
      return SignalProducer(error: error)
    }

    return SignalProducer(value: .template)
  }

  internal func fetchComments(project project: Project) -> SignalProducer<CommentsEnvelope, ErrorEnvelope> {

    if let error = fetchCommentsError {
      return SignalProducer(error: error)
    } else if let comments = fetchCommentsResponse {
      return SignalProducer(
        value: CommentsEnvelope(
          comments: comments,
          urls: CommentsEnvelope.UrlsEnvelope(
            api: CommentsEnvelope.UrlsEnvelope.ApiEnvelope(
              moreComments: ""
            )
          )
        )
      )
    }
    return .empty
  }

  internal func fetchComments(paginationUrl url: String) -> SignalProducer<CommentsEnvelope, ErrorEnvelope> {
    if let error = fetchCommentsError {
      return SignalProducer(error: error)
    } else if let comments = fetchCommentsResponse {
      return SignalProducer(
        value: CommentsEnvelope(
          comments: comments,
          urls: CommentsEnvelope.UrlsEnvelope(
            api: CommentsEnvelope.UrlsEnvelope.ApiEnvelope(
              moreComments: ""
            )
          )
        )
      )
    }
    return .empty
  }

  internal func fetchComments(update update: Update) -> SignalProducer<CommentsEnvelope, ErrorEnvelope> {

    if let error = fetchCommentsError {
      return SignalProducer(error: error)
    } else if let comments = fetchCommentsResponse {
      return SignalProducer(
        value: CommentsEnvelope(
          comments: comments,
          urls: CommentsEnvelope.UrlsEnvelope(
            api: CommentsEnvelope.UrlsEnvelope.ApiEnvelope(
              moreComments: ""
            )
          )
        )
      )
    }
    return .empty
  }

  internal func fetchConfig() -> SignalProducer<Config, ErrorEnvelope> {
    guard let config = self.fetchConfigResponse else { return .empty }
    return SignalProducer(value: config)
  }

  internal func fetchFriends() -> SignalProducer<FindFriendsEnvelope, ErrorEnvelope> {
    if let response = fetchFriendsResponse {
      return SignalProducer(value: response)
    } else if let error = fetchFriendsError {
      return SignalProducer(error: error)
    }

    return SignalProducer(value: .template)
  }

  internal func fetchFriends(paginationUrl paginationUrl: String)
    -> SignalProducer<FindFriendsEnvelope, ErrorEnvelope> {
    return self.fetchFriends()
  }

  internal func fetchFriendStats() -> SignalProducer<FriendStatsEnvelope, ErrorEnvelope> {
    if let response = fetchFriendStatsResponse {
      return SignalProducer(value: response)
    } else if let error = fetchFriendStatsError {
      return SignalProducer(error: error)
    }
    return SignalProducer(value: .template)
  }

  internal func followAllFriends() -> SignalProducer<VoidEnvelope, ErrorEnvelope> {
    return SignalProducer(value: VoidEnvelope())
  }

  internal func followFriend(userId id: Int) -> SignalProducer<User, ErrorEnvelope> {
    if let error = followFriendError {
      return SignalProducer(error: error)
    }

    return SignalProducer(value:
      .template
        |> User.lens.id .~ id
        |> User.lens.isFriend .~ true
    )
  }

  internal func unfollowFriend(userId id: Int) -> SignalProducer<VoidEnvelope, ErrorEnvelope> {
    if let error = unfollowFriendError {
      return SignalProducer(error: error)
    }

    return SignalProducer(value: VoidEnvelope())
  }

  internal func login(oauthToken: OauthTokenAuthType) -> MockService {
    return self |> MockService.lens.oauthToken .~ oauthToken
  }

  internal func logout() -> MockService {
    return self |> MockService.lens.oauthToken .~ nil
  }

  internal func fetchActivities(count count: Int?) -> SignalProducer<ActivityEnvelope, ErrorEnvelope> {

    if let error = fetchActivitiesError {
      return SignalProducer(error: error)
    } else if let activities = fetchActivitiesResponse {
      return SignalProducer(
        value: ActivityEnvelope(
          activities: activities,
          urls: ActivityEnvelope.UrlsEnvelope(
            api: ActivityEnvelope.UrlsEnvelope.ApiEnvelope(
              moreActivities: "http://\(Secrets.Api.Endpoint.production)/gimme/more"
            )
          )
        )
      )
    }
    return .empty
  }

  internal func fetchActivities(paginationUrl paginationUrl: String)
    -> SignalProducer<ActivityEnvelope, ErrorEnvelope> {
      return self.fetchActivities(count: nil)
  }

  func fetchBacking(forProject project: Project, forUser user: User)
    -> SignalProducer<Backing, ErrorEnvelope> {

    return SignalProducer(
      value: fetchBackingResponse
        |> Backing.lens.backer .~ user
        |> Backing.lens.backerId .~ user.id
        |> Backing.lens.projectId .~ project.id
    )
  }

  internal func fetchDiscovery(paginationUrl paginationUrl: String)
    -> SignalProducer<DiscoveryEnvelope, ErrorEnvelope> {

      if let error = fetchDiscoveryError {
        return SignalProducer(error: error)
      }

      let project: Int -> Project = {
        .template |> Project.lens.id .~ ($0 + paginationUrl.hashValue)
      }
      let envelope = self.fetchDiscoveryResponse ?? (.template
        |> DiscoveryEnvelope.lens.projects .~ (1...4).map(project)
        |> DiscoveryEnvelope.lens.urls.api.moreProjects .~ paginationUrl + "+1"
      )

      return SignalProducer(value: envelope)
  }

  internal func fetchDiscovery(params params: DiscoveryParams)
    -> SignalProducer<DiscoveryEnvelope, ErrorEnvelope> {

      if let error = fetchDiscoveryError {
        return SignalProducer(error: error)
      }

      let project: Int -> Project = {
        .template |> Project.lens.id %~ const($0 + params.hashValue)
      }
      let envelope = self.fetchDiscoveryResponse ?? (.template
        |> DiscoveryEnvelope.lens.projects .~ (1...4).map(project)
      )

      return SignalProducer(value: envelope)
  }

  internal func fetchMessageThread(messageThreadId messageThreadId: Int)
    -> SignalProducer<MessageThreadEnvelope, ErrorEnvelope> {

      return SignalProducer(
        value: MessageThreadEnvelope(
          participants: [.template, .template |> User.lens.id .~ 2],
          messages: [
            .template |> Message.lens.id .~ 1,
            .template |> Message.lens.id .~ 2,
            .template |> Message.lens.id .~ 3
          ],
          messageThread: self.fetchMessageThreadResponse
        )
      )
  }

  internal func fetchMessageThread(backing backing: Backing)
    -> SignalProducer<MessageThreadEnvelope, ErrorEnvelope> {

      return SignalProducer(
        value: MessageThreadEnvelope(
          participants: [.template, .template |> User.lens.id .~ 2],
          messages: [
            .template |> Message.lens.id .~ 1,
            .template |> Message.lens.id .~ 2,
            .template |> Message.lens.id .~ 3
          ],
          messageThread: self.fetchMessageThreadResponse
        )
      )
  }

  internal func fetchMessageThreads(mailbox mailbox: Mailbox, project: Project?)
    -> SignalProducer<MessageThreadsEnvelope, ErrorEnvelope> {

      return SignalProducer(value:
        MessageThreadsEnvelope(
          messageThreads: self.fetchMessageThreadsResponse,
          urls: MessageThreadsEnvelope.UrlsEnvelope(
            api: MessageThreadsEnvelope.UrlsEnvelope.ApiEnvelope(
              moreMessageThreads: ""
            )
          )
        )
      )
  }

  internal func fetchMessageThreads(paginationUrl paginationUrl: String)
    -> SignalProducer<MessageThreadsEnvelope, ErrorEnvelope> {

      return SignalProducer(value:
        MessageThreadsEnvelope(
          messageThreads: self.fetchMessageThreadsResponse,
          urls: MessageThreadsEnvelope.UrlsEnvelope(
            api: MessageThreadsEnvelope.UrlsEnvelope.ApiEnvelope(
              moreMessageThreads: ""
            )
          )
        )
      )
  }

  internal func fetchProjectNotifications() -> SignalProducer<[ProjectNotification], ErrorEnvelope> {
    return SignalProducer(value: self.fetchProjectNotificationsResponse)
  }

  internal func fetchProject(param param: Param) -> SignalProducer<Project, ErrorEnvelope> {
    if let project = self.fetchProjectResponse {
      return SignalProducer(value: project)
    }
    return SignalProducer(
      value: .template
        |> Project.lens.id %~ { param.id ?? $0 }
        |> Project.lens.slug %~ { param.slug ?? $0 }
    )
  }

  internal func fetchProject(params: DiscoveryParams) -> SignalProducer<DiscoveryEnvelope, ErrorEnvelope> {
    if let envelope = self.fetchDiscoveryResponse {
      return SignalProducer(value: envelope)
    }
    let envelope = .template
      |> DiscoveryEnvelope.lens.projects .~ [
        .template |> Project.lens.id .~ params.hashValue
    ]
    return SignalProducer(value: envelope)
  }

  internal func fetchProject(project project: Project) -> SignalProducer<Project, ErrorEnvelope> {
    if let project = self.fetchProjectResponse {
      return SignalProducer(value: project)
    }
    return SignalProducer(value: project)
  }

  internal func fetchProjectActivities(forProject project: Project) ->
    SignalProducer<ProjectActivityEnvelope, ErrorEnvelope> {

    if let error = fetchProjectActivitiesError {
      return SignalProducer(error: error)
    } else if let activities = fetchProjectActivitiesResponse {
      return SignalProducer(
        value: ProjectActivityEnvelope(
          activities: activities,
          urls: ProjectActivityEnvelope.UrlsEnvelope(
            api: ProjectActivityEnvelope.UrlsEnvelope.ApiEnvelope(
              moreActivities: "http://\(Secrets.Api.Endpoint.production)/gimme/more"
            )
          )
        )
      )
    }
    return .empty
  }

  internal func fetchProjectActivities(paginationUrl paginationUrl: String)
    -> SignalProducer<ProjectActivityEnvelope, ErrorEnvelope> {

    if let error = fetchProjectActivitiesError {
      return SignalProducer(error: error)
    } else if let activities = fetchProjectActivitiesResponse {
      return SignalProducer(
        value: ProjectActivityEnvelope(
          activities: activities,
          urls: ProjectActivityEnvelope.UrlsEnvelope(
            api: ProjectActivityEnvelope.UrlsEnvelope.ApiEnvelope(
              moreActivities: ""
            )
          )
        )
      )
    }
    return .empty
  }

  internal func fetchProjects(member member: Bool) -> SignalProducer<ProjectsEnvelope, ErrorEnvelope> {

    if let error = fetchProjectsError {
      return SignalProducer(error: error)
    } else if let projects = fetchProjectsResponse {
      return SignalProducer(
        value: ProjectsEnvelope(
          projects: projects,
          urls: ProjectsEnvelope.UrlsEnvelope(
            api: ProjectsEnvelope.UrlsEnvelope.ApiEnvelope(
              moreProjects: ""
            )
          )
        )
      )
    }
    return .empty
  }

  internal func fetchProjects(paginationUrl paginationUrl: String) ->
    SignalProducer<ProjectsEnvelope, ErrorEnvelope> {
      return fetchProjects(member: true)
  }

  internal func fetchProjectStats(projectId projectId: Int) ->
    SignalProducer<ProjectStatsEnvelope, ErrorEnvelope> {
      if let error = fetchProjectStatsError {
        return SignalProducer(error: error)
      } else if let response = fetchProjectStatsResponse {
        return SignalProducer(value: response)
      }

      return SignalProducer(value: .template)
  }

  internal func fetchRewardShippingRules(projectId projectId: Int, rewardId: Int)
    -> SignalProducer<ShippingRulesEnvelope, ErrorEnvelope> {

      return .init(value: .init(shippingRules: fetchShippingRulesResponse))
  }

  internal func fetchUserProjectsBacked() -> SignalProducer<ProjectsEnvelope, ErrorEnvelope> {
    if let error = fetchUserProjectsBackedError {
      return SignalProducer(error: error)
    } else if let projects = fetchUserProjectsBackedResponse {
      return SignalProducer(
        value: ProjectsEnvelope(
          projects: projects,
          urls: ProjectsEnvelope.UrlsEnvelope(
            api: ProjectsEnvelope.UrlsEnvelope.ApiEnvelope(
              moreProjects: ""
            )
          )
        )
      )
    }
    return .empty
  }

  internal func fetchUserProjectsBacked(paginationUrl url: String)
    -> SignalProducer<ProjectsEnvelope, ErrorEnvelope> {

    if let error = fetchUserProjectsBackedError {
      return SignalProducer(error: error)
    } else if let projects = fetchUserProjectsBackedResponse {
      return SignalProducer(
        value: ProjectsEnvelope(
          projects: projects,
          urls: ProjectsEnvelope.UrlsEnvelope(
            api: ProjectsEnvelope.UrlsEnvelope.ApiEnvelope(
              moreProjects: ""
            )
          )
        )
      )
    }
    return .empty
  }

  internal func fetchUserSelf() -> SignalProducer<User, ErrorEnvelope> {
    if let error = fetchUserSelfError {
      return SignalProducer(error: error)
    }

    return SignalProducer(value: self.fetchUserSelfResponse ?? .template)
  }

  internal func fetchSurveyResponse(surveyResponseId id: Int)
    -> SignalProducer<SurveyResponse, ErrorEnvelope> {
    if let response = fetchSurveyResponseResponse {
      return SignalProducer(value: response)
    } else if let error = fetchSurveyResponseError {
      return SignalProducer(error: error)
    }
    return SignalProducer(value: .template |> SurveyResponse.lens.id .~ id)
  }

  internal func fetchUnansweredSurveyResponses() -> SignalProducer<[SurveyResponse], ErrorEnvelope> {
    return SignalProducer(value: self.fetchUnansweredSurveyResponsesResponse)
  }

  internal func fetchUser(userId userId: Int) -> SignalProducer<User, ErrorEnvelope> {
    if let error = self.fetchUserError {
      return SignalProducer(error: error)
    }
    return SignalProducer(value: self.fetchUserResponse ?? (.template |> User.lens.id .~ userId))
  }

  internal func fetchUser(user: User) -> SignalProducer<User, ErrorEnvelope> {
    if let error = self.fetchUserError {
      return SignalProducer(error: error)
    }
    return SignalProducer(value: fetchUserResponse ?? user)
  }

  internal func fetchCategories() -> SignalProducer<CategoriesEnvelope, ErrorEnvelope> {

    return SignalProducer(value: self.fetchCategoriesResponse ?? .template)
  }

  internal func fetchCategory(param param: Param) -> SignalProducer<KsApi.Category, ErrorEnvelope> {
    switch param {
    case let .id(id):
      return SignalProducer(value: .template |> Category.lens.id .~ id)
    case let .slug(slug):
      return SignalProducer(value: .template |> Category.lens.slug .~ slug)
    }
  }

  internal func incrementVideoCompletion(forProject project: Project) ->
    SignalProducer<VoidEnvelope, ErrorEnvelope> {
      if let error = incrementVideoCompletionError {
        return .init(error: error)
      } else {
        return .init(value: VoidEnvelope())
      }
  }

  internal func incrementVideoStart(forProject project: Project) ->
    SignalProducer<VoidEnvelope, ErrorEnvelope> {
      if let error = incrementVideoStartError {
        return .init(error: error)
      } else {
        return .init(value: VoidEnvelope())
      }
  }

  internal func toggleStar(project: Project) -> SignalProducer<StarEnvelope, ErrorEnvelope> {
    guard let toggleStarResponse = toggleStarResponse else { return .init(error: .couldNotParseJSON) }
    return .init(value: toggleStarResponse)
  }

  internal func star(project: Project) -> SignalProducer<StarEnvelope, ErrorEnvelope> {
    let project = project |> Project.lens.personalization.isStarred .~ true
    return .init(value: .template |> StarEnvelope.lens.project .~ project)
  }

  internal func login(email email: String, password: String, code: String?) ->
    SignalProducer<AccessTokenEnvelope, ErrorEnvelope> {

    if let error = loginError {
      return SignalProducer(error: error)
    } else if let accessTokenEnvelope = loginResponse {
      return SignalProducer(value: accessTokenEnvelope)
    } else if let resendCodeResponse = resendCodeResponse {
      return SignalProducer(error: resendCodeResponse)
    } else if let resendCodeError = resendCodeError {
      return SignalProducer(error: resendCodeError)
    }

    return SignalProducer(value: AccessTokenEnvelope(accessToken: "deadbeef", user: .template))
  }

  internal func login(facebookAccessToken facebookAccessToken: String, code: String?) ->
    SignalProducer<AccessTokenEnvelope, ErrorEnvelope> {

    if let error = loginError {
      return SignalProducer(error: error)
    } else if let accessTokenEnvelope = loginResponse {
      return SignalProducer(value: accessTokenEnvelope)
    } else if let resendCodeResponse = resendCodeResponse {
      return SignalProducer(error: resendCodeResponse)
    } else if let resendCodeError = resendCodeError {
      return SignalProducer(error: resendCodeError)
    }

    return SignalProducer(value: AccessTokenEnvelope(accessToken: "deadbeef", user: .template))
  }

  internal func markAsRead(messageThread messageThread: MessageThread)
    -> SignalProducer<MessageThread, ErrorEnvelope> {
      return SignalProducer(value: messageThread)
  }

  internal func postComment(body: String, toProject project: Project) ->
    SignalProducer<Comment, ErrorEnvelope> {

    if let error = self.postCommentError {
      return SignalProducer(error: error)
    } else if let comment = self.postCommentResponse {
      return SignalProducer(value: comment)
    }
    return .empty
  }

  func postComment(body: String, toUpdate update: Update) -> SignalProducer<Comment, ErrorEnvelope> {

    if let error = self.postCommentError {
      return SignalProducer(error: error)
    } else if let comment = self.postCommentResponse {
      return SignalProducer(value: comment)
    }
    return .empty
  }

  func resetPassword(email email: String) -> SignalProducer<User, ErrorEnvelope> {
    if let response = resetPasswordResponse {
      return SignalProducer(value: response)
    } else if let error = resetPasswordError {
      return SignalProducer(error: error)
    }
    return SignalProducer(value: .template)
  }

  func register(pushToken pushToken: String) -> SignalProducer<VoidEnvelope, ErrorEnvelope> {
    return SignalProducer(value: VoidEnvelope())
  }

  internal func searchMessages(query query: String, project: Project?)
    -> SignalProducer<MessageThreadsEnvelope, ErrorEnvelope> {
      return SignalProducer(value:
        MessageThreadsEnvelope(
          messageThreads: self.fetchMessageThreadsResponse,
          urls: MessageThreadsEnvelope.UrlsEnvelope(
            api: MessageThreadsEnvelope.UrlsEnvelope.ApiEnvelope(
              moreMessageThreads: ""
            )
          )
        )
      )
  }

  internal func sendMessage(body body: String, toSubject subject: MessageSubject)
    -> SignalProducer<Message, ErrorEnvelope> {

      return SignalProducer(
        value: .template
          |> Message.lens.id .~ body.hashValue
          |> Message.lens.body .~ body
      )
  }

  internal func signup(name name: String,
                          email: String,
                          password: String,
                          passwordConfirmation: String,
                          sendNewsletters: Bool) -> SignalProducer<AccessTokenEnvelope, ErrorEnvelope> {
    if let error = signupError {
      return SignalProducer(error: error)
    } else if let accessTokenEnvelope = signupResponse {
      return SignalProducer(value: accessTokenEnvelope)
    }
    return SignalProducer(value:
      AccessTokenEnvelope(
        accessToken: "deadbeef",
        user: .template
          |> User.lens.name .~ name
          |> User.lens.newsletters.weekly .~ sendNewsletters
      )
    )
  }

  internal func signup(facebookAccessToken facebookAccessToken: String, sendNewsletters: Bool) ->
    SignalProducer<AccessTokenEnvelope, ErrorEnvelope> {

    if let error = signupError {
      return SignalProducer(error: error)
    } else if let accessTokenEnvelope = signupResponse {
      return SignalProducer(value: accessTokenEnvelope)
    }
    return SignalProducer(value:
      AccessTokenEnvelope(
        accessToken: "deadbeef",
        user: .template
      )
    )
  }

  func submitApplePay(
    checkoutUrl checkoutUrl: String,
                stripeToken: String,
                paymentInstrumentName: String,
                paymentNetwork: String,
                transactionIdentifier: String) -> SignalProducer<SubmitApplePayEnvelope, ErrorEnvelope> {

    return SignalProducer(value: self.submitApplePayResponse)
  }

  internal func updateProjectNotification(notification: ProjectNotification)
    -> SignalProducer<ProjectNotification, ErrorEnvelope> {
      if let error = updateProjectNotificationError {
        return SignalProducer(error: error)
      }
      return SignalProducer(value: notification)
  }

  internal func updateUserSelf(user: User) -> SignalProducer<User, ErrorEnvelope> {
    if let error = updateUserSelfError {
      return SignalProducer(error: error)
    }
    return SignalProducer(value: user)
  }

  internal func fetchUpdate(updateId updateId: Int, projectParam: Param)
    -> SignalProducer<Update, ErrorEnvelope> {

      return SignalProducer(value: self.fetchUpdateResponse |> Update.lens.id .~ updateId)
  }

  internal func fetchUpdateDraft(forProject project: Project) -> SignalProducer<UpdateDraft, ErrorEnvelope> {
    if let error = self.fetchDraftError {
      return SignalProducer(error: error)
    }
    return SignalProducer(value: fetchDraftResponse ?? .template)
  }

  internal func update(draft draft: UpdateDraft, title: String, body: String, isPublic: Bool)
    -> SignalProducer<UpdateDraft, ErrorEnvelope> {

      if let error = self.updateDraftError {
        return SignalProducer(error: error)
      }
      let updatedDraft = draft
        |> UpdateDraft.lens.update.title .~ title
        |> UpdateDraft.lens.update.body .~ body
        |> UpdateDraft.lens.update.isPublic .~ isPublic

      return SignalProducer(value: updatedDraft)
  }

  internal func updatePledge(
    project project: Project,
            amount: Double,
            reward: Reward?,
            shippingLocation: Location?,
            tappedReward: Bool) -> SignalProducer<UpdatePledgeEnvelope, ErrorEnvelope> {

    return SignalProducer(value: self.updatePledgeResponse)
  }

  internal func addImage(file fileURL: NSURL, toDraft draft: UpdateDraft)
    -> SignalProducer<UpdateDraft.Image, ErrorEnvelope> {

      if let error = addAttachmentError {
        return SignalProducer(error: error)
      }

      return SignalProducer(value: addAttachmentResponse ?? .template)
  }

  internal func delete(image image: UpdateDraft.Image, fromDraft draft: UpdateDraft)
    -> SignalProducer<UpdateDraft.Image, ErrorEnvelope> {

      if let error = removeAttachmentError {
        return SignalProducer(error: error)
      }

      return SignalProducer(value: removeAttachmentResponse ?? .template)
  }

  internal func addVideo(file fileURL: NSURL, toDraft draft: UpdateDraft)
    -> SignalProducer<UpdateDraft.Video, ErrorEnvelope> {

      return .empty
  }

  internal func changePaymentMethod(project project: Project)
    -> SignalProducer<ChangePaymentMethodEnvelope, ErrorEnvelope> {

      return SignalProducer(value: self.changePaymentMethodResponse)
  }

  internal func delete(video video: UpdateDraft.Video, fromDraft draft: UpdateDraft)
    -> SignalProducer<UpdateDraft.Video, ErrorEnvelope> {

      return .empty
  }

  internal func publish(draft draft: UpdateDraft) -> SignalProducer<Update, ErrorEnvelope> {
    if let error = publishUpdateError {
      return SignalProducer(error: error)
    }

    return SignalProducer(value: fetchUpdateResponse)
  }

  internal func previewUrl(forDraft draft: UpdateDraft) -> NSURL? {
    return NSURL(
      string: "https://\(Secrets.Api.Endpoint.production)/projects/\(draft.update.projectId)/updates/"
        + "\(draft.update.id)/preview"
    )
  }
}

private extension MockService {
  // swiftlint:disable type_name
  enum lens {
    static let oauthToken = Lens<MockService, OauthTokenAuthType?>(
      view: { $0.oauthToken },
      set: {
        MockService(
          appId: $1.appId,
          serverConfig: $1.serverConfig,
          oauthToken: $0,
          language: $1.language,
          buildVersion: $1.buildVersion,
          changePaymentMethodResponse: $1.changePaymentMethodResponse,
          createPledgeResponse: $1.createPledgeResponse,
          facebookConnectResponse: $1.facebookConnectResponse,
          facebookConnectError: $1.facebookConnectError,
          fetchActivitiesResponse: $1.fetchActivitiesResponse,
          fetchActivitiesError: $1.fetchActivitiesError,
          fetchBackingResponse: $1.fetchBackingResponse,
          fetchCategoriesResponse: $1.fetchCategoriesResponse,
          fetchCommentsResponse: $1.fetchCommentsResponse,
          fetchCommentsError: $1.fetchCommentsError,
          fetchConfigResponse: $1.fetchConfigResponse,
          fetchDiscoveryResponse: $1.fetchDiscoveryResponse,
          fetchDiscoveryError: $1.fetchDiscoveryError,
          fetchFriendsResponse: $1.fetchFriendsResponse,
          fetchFriendsError: $1.fetchFriendsError,
          fetchFriendStatsResponse: $1.fetchFriendStatsResponse,
          fetchFriendStatsError: $1.fetchFriendStatsError,
          fetchDraftResponse: $1.fetchDraftResponse,
          fetchDraftError: $1.fetchDraftError,
          addAttachmentResponse: $1.addAttachmentResponse,
          addAttachmentError: $1.addAttachmentError,
          removeAttachmentResponse: $1.removeAttachmentResponse,
          removeAttachmentError: $1.removeAttachmentError,
          publishUpdateError: $1.publishUpdateError,
          fetchMessageThreadResponse: $1.fetchMessageThreadResponse,
          fetchMessageThreadsResponse: $1.fetchMessageThreadsResponse,
          fetchProjectActivitiesResponse: $1.fetchProjectActivitiesResponse,
          fetchProjectActivitiesError: $1.fetchProjectActivitiesError,
          fetchProjectResponse: $1.fetchProjectResponse,
          fetchProjectNotificationsResponse: $1.fetchProjectNotificationsResponse,
          fetchProjectsResponse: $1.fetchProjectsResponse,
          fetchProjectsError: $1.fetchProjectsError,
          fetchProjectStatsResponse: $1.fetchProjectStatsResponse,
          fetchProjectStatsError: $1.fetchProjectStatsError,
          fetchShippingRulesResponse: $1.fetchShippingRulesResponse,
          fetchUserProjectsBackedResponse: $1.fetchUserProjectsBackedResponse,
          fetchUserProjectsBackedError: $1.fetchUserProjectsBackedError,
          fetchUserResponse: $1.fetchUserResponse,
          fetchUserError: $1.fetchUserError,
          fetchUserSelfResponse: $1.fetchUserSelfResponse,
          followFriendError: $1.followFriendError,
          incrementVideoCompletionError: $1.incrementVideoCompletionError,
          incrementVideoStartError: $1.incrementVideoStartError,
          fetchSurveyResponseResponse: $1.fetchSurveyResponseResponse,
          fetchSurveyResponseError: $1.fetchSurveyResponseError,
          fetchUnansweredSurveyResponsesResponse: $1.fetchUnansweredSurveyResponsesResponse,
          fetchUpdateResponse: $1.fetchUpdateResponse,
          fetchUserSelfError: $1.fetchUserSelfError,
          postCommentResponse: $1.postCommentResponse,
          postCommentError: $1.postCommentError,
          loginResponse: $1.loginResponse,
          loginError: $1.loginError,
          resendCodeResponse: $1.resendCodeResponse,
          resendCodeError: $1.resendCodeError,
          resetPasswordResponse: $1.resetPasswordResponse,
          resetPasswordError: $1.resetPasswordError,
          signupResponse: $1.signupResponse,
          signupError: $1.signupError,
          submitApplePayResponse: $1.submitApplePayResponse,
          toggleStarResponse: $1.toggleStarResponse,
          unfollowFriendError: $1.unfollowFriendError,
          updateDraftError: $1.updateDraftError,
          updatePledgeResponse: $1.updatePledgeResponse,
          updateProjectNotificationResponse: $1.updateProjectNotificationResponse,
          updateProjectNotificationError: $1.updateProjectNotificationError,
          updateUserSelfError: $1.updateUserSelfError
        )
      }
    )
  }
  // swiftlint:enable type_name
}
