import Argo
import Curry

public struct PushEnvelope {
  public let activity: Activity?
  public let aps: ApsEnvelope
  public let forCreator: Bool?
  public let message: Message?
  public let project: Project?
  public let survey: Survey?
  public let update: Update?

  public struct Activity {
    public let category: KsApi.Activity.Category
    public let commentId: Int?
    public let id: Int
    public let projectId: Int?
    public let projectPhoto: String?
    public let updateId: Int?
    public let userPhoto: String?
  }

  public struct ApsEnvelope {
    public let alert: String
  }

  public struct Message {
    public let messageThreadId: Int
    public let projectId: Int
  }

  public struct Project {
    public let id: Int
    public let photo: String?
  }

  public struct Survey {
    public let id: Int
    public let projectId: Int
  }

  public struct Update {
    public let id: Int
    public let projectId: Int
  }
}

extension PushEnvelope: Decodable {
  public static func decode(json: JSON) -> Decoded<PushEnvelope> {
    let create = curry(PushEnvelope.init)

    let update: Decoded<Update> = json <| "update" <|> json <| "post"
    let optionalUpdate: Decoded<Update?> = update.map(Optional.Some) <|> .Success(nil)

    return create
      <^> json <|? "activity"
      <*> json <| "aps"
      <*> json <|? "for_creator"
      <*> json <|? "message"
      <*> json <|? "project"
      <*> json <|? "survey"
      <*> optionalUpdate
  }
}

extension PushEnvelope.Activity: Decodable {
  public static func decode(json: JSON) -> Decoded<PushEnvelope.Activity> {
    let create = curry(PushEnvelope.Activity.init)
    return create
      <^> json <| "category"
      <*> json <|? "comment_id"
      <*> json <| "id"
      <*> json <|? "project_id"
      <*> json <|? "project_photo"
      <*> json <|? "update_id"
      <*> json <|? "user_photo"
  }
}

extension PushEnvelope.ApsEnvelope: Decodable {
  public static func decode(json: JSON) -> Decoded<PushEnvelope.ApsEnvelope> {
    return curry(PushEnvelope.ApsEnvelope.init)
      <^> json <| "alert"
  }
}

extension PushEnvelope.Message: Decodable {
  public static func decode(json: JSON) -> Decoded<PushEnvelope.Message> {
    return curry(PushEnvelope.Message.init)
      <^> json <| "message_thread_id"
      <*> json <| "project_id"
  }
}

extension PushEnvelope.Project: Decodable {
  public static func decode(json: JSON) -> Decoded<PushEnvelope.Project> {
    return curry(PushEnvelope.Project.init)
      <^> json <| "id"
      <*> json <|? "photo"
  }
}

extension PushEnvelope.Survey: Decodable {
  public static func decode(json: JSON) -> Decoded<PushEnvelope.Survey> {
    return curry(PushEnvelope.Survey.init)
      <^> json <| "id"
      <*> json <| "project_id"
  }
}

extension PushEnvelope.Update: Decodable {
  public static func decode(json: JSON) -> Decoded<PushEnvelope.Update> {
    return curry(PushEnvelope.Update.init)
      <^> json <| "id"
      <*> json <| "project_id"
  }
}
