import Argo

/// Represents a way to paramterize a model by either an `id` integer or `slug` string.
public enum Param {
  case id(Int)
  case slug(String)

  /// Returns the `id` of the param if it is of type `.id`.
  public var id: Int? {
    if case let .id(id) = self {
      return id
    }
    return nil
  }

  /// Returns the `slug` of the param if it is of type `.slug`.
  public var slug: String? {
    if case let .slug(slug) = self {
      return slug
    }
    return nil
  }

  /// Returns a value suitable for interpolating into a URL.
  public var urlComponent: String {
    switch self {
    case let .id(id):
      return String(id)
    case let .slug(slug):
      return slug
    }
  }

  public var escapedUrlComponent: String {
    switch self {
    case let .id(id):
      return String(id)
    case let .slug(slug):
      return encodeForRFC3986(slug) ?? ""
    }
  }
}

extension Param: Equatable {}
public func == (lhs: Param, rhs: Param) -> Bool {

  switch (lhs, rhs) {
  case let (.id(lhs), .id(rhs)):
    return lhs == rhs
  case let (.slug(lhs), .slug(rhs)):
    return lhs == rhs
  case let (.id(lhs), .slug(rhs)):
    return String(lhs) == rhs
  case let (.slug(lhs), .id(rhs)):
    return lhs == String(rhs)
  }
}

extension Param: Decodable {
  public static func decode(json: JSON) -> Decoded<Param> {
    switch json {
    case let .String(slug):
      return .Success(.slug(slug))
    case let .Number(number):
      return .Success(.id(number.integerValue))
    default:
      return .Failure(.Custom("Param must be a number or string."))
    }
  }
}

private let allowableRFC3986: NSCharacterSet = {
  let set = NSMutableCharacterSet.alphanumericCharacterSet()
  set.addCharactersInString("-._~/?")
  return set
}()

private func encodeForRFC3986(str: String) -> String? {
  return str.stringByAddingPercentEncodingWithAllowedCharacters(allowableRFC3986)
}
