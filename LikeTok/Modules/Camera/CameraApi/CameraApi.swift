import UIKit
import Alamofire
import AVFoundation

final class CameraApiWorker {
    
    class EUploadedFile: Codable {
        var url: String = ""
    }
    
    static func encodeVideo(at videoURL: URL, completionHandler: ((Data?, Error?) -> Void)?)  {
        let avAsset = AVURLAsset(url: videoURL, options: nil)

        //Create Export session
        guard let exportSession = AVAssetExportSession(asset: avAsset, presetName: AVAssetExportPresetPassthrough) else {
            completionHandler?(nil, nil)
            return
        }

        //Creating temp path to save the converted video
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        let filePath = documentsDirectory.appendingPathComponent("\(UUID().uuidString)rendered-Video.mp4")

        //Check if the file already exists then remove the previous file
        if FileManager.default.fileExists(atPath: filePath.path) {
            do {
                try FileManager.default.removeItem(at: filePath)
            } catch {
                completionHandler?(nil, error)
            }
        }

        exportSession.outputURL = filePath
        exportSession.outputFileType = AVFileType.mp4
        exportSession.shouldOptimizeForNetworkUse = true
        let start = CMTimeMakeWithSeconds(0.0, preferredTimescale: 0)
        let range = CMTimeRangeMake(start: start, duration: avAsset.duration)
        exportSession.timeRange = range

        exportSession.exportAsynchronously(completionHandler: {() -> Void in
            switch exportSession.status {
            case .failed:
                print(exportSession.error ?? "NO ERROR")
                completionHandler?(nil, exportSession.error)
            case .cancelled:
                print("Export canceled")
                completionHandler?(nil, nil)
            case .completed:
                //Video conversion finished
                print("Successful!")
                print(exportSession.outputURL ?? "NO OUTPUT URL")
                let fileData = try? Data(contentsOf: exportSession.outputURL!)
                completionHandler?(fileData, nil)

                default: break
            }

        })
    }
    
    public static func upload(_ fileData: Data, with key: String, fileExtension: String, to url: String, preview: Data, _ completion: @escaping (Swift.Result<String,Error>) -> Void) {
        Alamofire.upload(multipartFormData: { (data) in
            data.append(fileData, withName: "video",
                        fileName: "file\(Date().timeIntervalSince1970)video.mp4",
                        mimeType: "video/mp4")
            data.append(preview, withName: "preview",
                        fileName: "file\(Date().timeIntervalSince1970)preview.jpg",
                        mimeType: "image/jpeg")
            print(data)
        }, to: url, method: .post, headers: Api.headers) { (encodingResult) in
            switch encodingResult {
            case .success(let uploadRequest, _, _):
                uploadRequest.uploadProgress(closure: { (prg) in
                    let progr = prg.fractionCompleted
                    print("upload progress:\(progr)")
                    DispatchQueue.main.async() {
                        if (progr == 1){
                            //Обработка сервера
                        }
                    }
                })
                uploadRequest.validate().responseObject { (response: DataResponse<UploadResponse>) in
                    switch response.result {
                    case .success(let value):
                        completion(.success("uuid"))
                        print("# uploadRequest: success")
                    case .failure(let error):
                        print(error)
                        completion(.failure(error))
                        print("# uploadRequest: error")
                    }
                }
                
            case .failure(let error):
                print(error)
            }
            //**//
        }
    }
    
    func createPost(_ adv: Bool, title: String, text: String = "mobile", tag: String, category: String, completion: @escaping (Swift.Result<CreatePostResponse?, NetworkError>) -> Void) {
        Api.Camera.createPost(adv: adv, title: title, text: text, tag: tag, category: category).request.responseJSON { response in
            guard let statusCode = response.response?.statusCode
            else {
                return
            }
            switch statusCode {
            case 200:
                if let data = response.data,
                   let response = try? JSONDecoder().decode(CreatePostResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
                
            }
        }
    }
    
    func publishPost(_ post: String, completion: @escaping (Swift.Result<PublishPostResponse?, NetworkError>) -> Void) {
        Api.Camera.publishPost(uuid: post).request.responseJSON { response in
            guard let statusCode = response.response?.statusCode
            else {
                return
            }
            switch statusCode {
            case 200:
                if let data = response.data,
                   let response = try? JSONDecoder().decode(PublishPostResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
                
            }
        }
    }
    
    func uploadAvatar(image: UIImage, completion: @escaping (Swift.Result<Any?, NetworkError>) -> Void) {
        //        Api.profile.uploadAvatar(image: image) { result in
        //            print(result)
        //        }.request.responseJSON { response in
        //            print(response)CreatePostResponse
        //        }
    }
    
    private func catchError<T: Decodable>(data: Data, type: T.Type) throws {
        let decoder = JSONDecoder()
        do {
            _ = try decoder.decode(type.self, from: data)
        } catch let decError as DecodingError {
            print("------------...........---------------")
            print(type.self)
            print(decError)
            print(decError.localizedDescription)
            print(decError.failureReason as Any)
            print("------------...........---------------")
        }
    }
    
}
