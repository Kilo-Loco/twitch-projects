import AWSLambdaEvents
import AWSLambdaRuntime
import Foundation
import Pinpoint

// Provided by lambda
let accessKeyId = ProcessInfo.processInfo.environment["AWS_ACCESS_KEY_ID"]
let secretAccessKey = ProcessInfo.processInfo.environment["AWS_SECRET_ACCESS_KEY"]

Lambda.run { (context, event: DynamoDB.Event, completion: @escaping (Result<String, Error>) -> Void) in
    let pinpointId = "f76b0764476644558afb0c58e22981c5"
    
    for record in event.records {
        guard let snapshot = record.change.newImage ?? record.change.oldImage else {
            return completion(.failure(LambdaError.noImage))
        }
        
        guard case .string(let deviceToken) = snapshot["deviceToken"] else {
            return completion(.failure(LambdaError.noDeviceToken))
        }
        
        guard case .string(let body) = snapshot["body"] else {
            return completion(.failure(LambdaError.noBody))
        }
        
        let message = Pinpoint.APNSMessage(
            body: body,
            sound: "bingbong.aiff",
            title: "Swift Lambda Push"
        )
        
        let messageConfig = Pinpoint.DirectMessageConfiguration(aPNSMessage: message)
        
        let messageRequest = Pinpoint.MessageRequest(messageConfiguration: messageConfig)
        
        let request = Pinpoint.SendMessagesRequest(applicationId: pinpointId, messageRequest: messageRequest)
        
        let pinpoint = Pinpoint(
            accessKeyId: accessKeyId,
            secretAccessKey: secretAccessKey,
            region: .uswest2
        )
        
        pinpoint.sendMessages(request)
    }
}

enum LambdaError: Error {
    case noImage, noDeviceToken, noBody
}
