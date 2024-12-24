import 'package:dio/dio.dart';

String handleError(DioException error) {
  // Check if there's a response with status code
  if (error.response?.statusCode != null) {
    switch (error.response?.statusCode) {
      case 100:
        return '${error.response?.statusCode} Continue: The server has received the request headers.';
      case 101:
        return '${error.response?.statusCode} Switching Protocols: The requester has asked the server to switch protocols.';
      case 102:
        return '${error.response?.statusCode} Processing: The server is processing the request but no response is available yet.';
      case 200:
        return '${error.response?.statusCode} OK: The request was successful.';
      case 201:
        return '${error.response?.statusCode} Created: The request was successful and a resource was created.';
      case 202:
        return '${error.response?.statusCode} Accepted: The request has been accepted for processing, but the processing is not complete.';
      case 203:
        return '${error.response?.statusCode} Non-Authoritative Information: The request was successful but the information may be from another source.';
      case 204:
        return '${error.response?.statusCode} No Content: The request was successful but there is no representation to return.';
      case 205:
        return '${error.response?.statusCode} Reset Content: The request was successful but the user agent should reset the view.';
      case 206:
        return '${error.response?.statusCode} Partial Content: The server is delivering only part of the resource due to a range header sent by the client.';
      case 207:
        return '${error.response?.statusCode} Multi-Status: The message body that follows is an XML message and can contain a number of separate response codes.';
      case 208:
        return '${error.response?.statusCode} Already Reported: The members of a DAV binding have already been enumerated in a previous reply to this request, and are not being included again.';
      case 226:
        return '${error.response?.statusCode} IM Used: The server has fulfilled a GET request for the resource and the response is a representation of the result of one or more instance-manipulations applied to the current instance.';
      case 300:
        return '${error.response?.statusCode} Multiple Choices: The request has more than one possible response.';
      case 301:
        return '${error.response?.statusCode} Moved Permanently: The URL of the requested resource has been changed permanently.';
      case 302:
        return '${error.response?.statusCode} Found: The URL of the requested resource has been changed temporarily.';
      case 303:
        return '${error.response?.statusCode} See Other: The response to the request can be found under another URL.';
      case 304:
        return '${error.response?.statusCode} Not Modified: The resource has not been modified since the version specified by the request headers.';
      case 305:
        return '${error.response?.statusCode} Use Proxy: The requested resource is only available through a proxy, whose address is provided in the response.';
      case 307:
        return '${error.response?.statusCode} Temporary Redirect: The request should be repeated with another URL, but future requests should still use the original URL.';
      case 308:
        return '${error.response?.statusCode} Permanent Redirect: The request and all future requests should be repeated using another URL.';
      case 400:
        return '${error.response?.statusCode} Bad Request: The server could not understand the request due to invalid syntax.';
      case 401:
        return '${error.response?.statusCode} Unauthorized: The client must authenticate itself to get the requested response.';
      case 402:
        return '${error.response?.statusCode} Payment Required: This response code is reserved for future use.';
      case 403:
        return '${error.response?.statusCode} Forbidden: The client does not have access rights to the content.';
      case 404:
        return '${error.response?.statusCode} Not Found: The server can not find the requested resource.';
      case 405:
        return '${error.response?.statusCode} Method Not Allowed: The request method is known by the server but is not supported by the target resource.';
      case 406:
        return '${error.response?.statusCode} Not Acceptable: The server can only generate a response that is not accepted by the client.';
      case 407:
        return '${error.response?.statusCode} Proxy Authentication Required: The client must first authenticate itself with the proxy.';
      case 408:
        return '${error.response?.statusCode} Request Timeout: The server would like to shut down this unused connection.';
      case 409:
        return '${error.response?.statusCode} Conflict: This response is sent when a request conflicts with the current state of the server.';
      case 410:
        return '${error.response?.statusCode} Gone: This response is sent when the requested content has been permanently deleted from the server, with no forwarding address.';
      case 411:
        return '${error.response?.statusCode} Length Required: The server rejected the request because the Content-Length header field is not defined and the server requires it.';
      case 412:
        return '${error.response?.statusCode} Precondition Failed: The client has indicated preconditions in its headers which the server does not meet.';
      case 413:
        return '${error.response?.statusCode} Payload Too Large: The request entity is larger than limits defined by the server.';
      case 414:
        return '${error.response?.statusCode} URI Too Long: The URI requested by the client is longer than the server is willing to interpret.';
      case 415:
        return '${error.response?.statusCode} Unsupported Media Type: The media format of the requested data is not supported by the server.';
      case 416:
        return '${error.response?.statusCode} Range Not Satisfiable: The range specified by the Range header field in the request can\'t be fulfilled.';
      case 417:
        return '${error.response?.statusCode} Expectation Failed: The server cannot meet the requirements of the Expect request-header field.';
      case 418:
        return '${error.response?.statusCode} I\'m a teapot: This code was defined in 1998 as one of the traditional IETF April Fools\' jokes, in RFC 2324.';
      case 421:
        return '${error.response?.statusCode} Misdirected Request: The request was directed at a server that is not able to produce a response.';
      case 422:
        return '${error.response?.statusCode} Unprocessable Entity: The server understands the content type of the request entity, and the syntax of the request entity is correct, but it was unable to process the contained instructions.';
      case 423:
        return '${error.response?.statusCode} Locked: The resource that is being accessed is locked.';
      case 424:
        return '${error.response?.statusCode} Failed Dependency: The request failed due to failure of a previous request.';
      case 425:
        return '${error.response?.statusCode} Too Early: Indicates that the server is unwilling to risk processing a request that might be replayed.';
      case 426:
        return '${error.response?.statusCode} Upgrade Required: The client should switch to a different protocol such as TLS/1.0.';
      case 428:
        return '${error.response?.statusCode} Precondition Required: The origin server requires the request to be conditional.';
      case 429:
        return '${error.response?.statusCode} Too Many Requests: The user has sent too many requests in a given amount of time ("rate limiting").';
      case 431:
        return '${error.response?.statusCode} Request Header Fields Too Large: The server is unwilling to process the request because its header fields are too large.';
      case 451:
        return '${error.response?.statusCode} Unavailable For Legal Reasons: The user-agent requested a resource that cannot legally be provided, such as a web page censored by a government.';
      case 500:
        return '${error.response?.statusCode} Internal Server Error.';
      case 501:
        return '${error.response?.statusCode} Not Implemented: The request method is not supported by the server and cannot be handled.';
      case 502:
        return '${error.response?.statusCode} Bad Gateway: The server, while acting as a gateway or proxy, received an invalid response from the upstream server.';
      case 503:
        return '${error.response?.statusCode} Service Unavailable: The server is not ready to handle the request.';
      case 504:
        return '${error.response?.statusCode} Gateway Timeout: The server, while acting as a gateway or proxy, did not get a response in time from the upstream server.';
      case 505:
        return '${error.response?.statusCode} HTTP Version Not Supported: The HTTP version used in the request is not supported by the server.';
      case 506:
        return '${error.response?.statusCode} Variant Also Negotiates: The server has an internal configuration error.';
      case 507:
        return '${error.response?.statusCode} Insufficient Storage: The server is unable to store the representation needed to complete the request.';
      case 508:
        return '${error.response?.statusCode} Loop Detected: The server detected an infinite loop while processing a request with "Depth: infinity".';
      case 510:
        return '${error.response?.statusCode} Not Extended: Further extensions to the request are required for the server to fulfill it.';
      case 511:
        return '${error.response?.statusCode} Network Authentication Required: The client needs to authenticate to gain network access.';
      default:
        return 'An unexpected error occurred';
    }
  }
  return 'Unexpected error occurred';
}

String handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return "Connection timeout, please try again.";
      case DioException.badCertificate:
      return "Bad certificate, please try again.";
    case DioExceptionType.sendTimeout:
      return "Send timeout, please try again.";
    case DioExceptionType.receiveTimeout:
      return "Receive timeout, please try again.";
    case DioExceptionType.badResponse:
      return handleError(error);
    case DioExceptionType.cancel:
      return "Request to server was cancelled.";
    case DioExceptionType.unknown:
    // Check for timeout in the exception message
      if (error.error.toString().contains("timed out") ||
          error.error.toString().contains("connection timed out")) {
        return "Connection timeout, please try again.";
      } else {
        return "Something went wrong, please try again.";
      }
    default:
      return "An unexpected error occurred.";
  }}


