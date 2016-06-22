import Argo
import Curry

public struct UpdateDraft {
  public let update: Update
  public let images: [Image]
  public let video: Video?

  public enum Attachment {
    case image(Image)
    case video(Video)
  }

  public struct Image {
    public let id: Int
    public let thumb: String
    public let full: String
  }

  public struct Video {
    public let id: Int
    public let status: Status
    public let frame: String

    public enum Status: String {
      case processing
      case failed
      case successful
    }
  }
}

extension UpdateDraft.Attachment {
  public var thumbUrl: String {
    switch self {
    case let .image(image):
      return image.thumb
    case let .video(video):
      return video.frame
    }
  }
}

extension UpdateDraft.Attachment: Equatable {}
public func == (lhs: UpdateDraft.Attachment, rhs: UpdateDraft.Attachment) -> Bool {
  switch (lhs, rhs) {
  case let (.image(lhs), .image(rhs)):
    return lhs.id == rhs.id
  case let (.video(lhs), .video(rhs)):
    return lhs.id == rhs.id
  default:
    return false
  }
}

extension UpdateDraft: Decodable {
  public static func decode(json: JSON) -> Decoded<UpdateDraft> {
    return curry(UpdateDraft.init)
      <^> Update.decode(json)
      <*> json <|| "images"
      <*> json <|? "video"
  }
}

extension UpdateDraft.Image: Decodable {
  public static func decode(json: JSON) -> Decoded<UpdateDraft.Image> {
    return curry(UpdateDraft.Image.init)
      <^> json <| "id"
      <*> json <| "thumb"
      <*> json <| "full"
  }
}

extension UpdateDraft.Video: Decodable {
  public static func decode(json: JSON) -> Decoded<UpdateDraft.Video> {
    return curry(UpdateDraft.Video.init)
      <^> json <| "id"
      <*> json <| "status"
      <*> json <| "frame"
  }
}

extension UpdateDraft.Video.Status: Decodable {
}