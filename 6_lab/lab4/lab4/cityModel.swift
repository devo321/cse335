//
//  cityModel.swift
//  lab4
//
//  Created by Deven Pile on 2/22/21.
//

import Foundation
import UIKit

class cityModel{
    var data = ["London", "Phoenix", "Tokyo", "Wellington", "Sydney"]
    var desc = ["The City of London is a historic financial district, home to both the Stock Exchange and the Bank of England. Modern corporate skyscrapers tower above the vestiges of medieval alleyways below. Affluent workers frequent its smart restaurants and bars. Tourists visit iconic, 17th-century St. Paul’s Cathedral, trace the city’s history at the Museum of London, and take in performances at the huge Barbican arts centre.",
        "Phoenix is the capital of the southwestern U.S. state of Arizona. Known for its year-round sun and warm temperatures, it anchors a sprawling, multicity metropolitan area known as the Valley of the Sun. It's known for high-end spa resorts, Jack Nicklaus–designed golf courses and vibrant nightclubs. Other highlights include the Desert Botanical Garden, displaying cacti and numerous native plants.",
        "Tokyo, Japan’s busy capital, mixes the ultramodern and the traditional, from neon-lit skyscrapers to historic temples. The opulent Meiji Shinto Shrine is known for its towering gate and surrounding woods. The Imperial Palace sits amid large public gardens. The city's many museums offer exhibits ranging from classical art (in the Tokyo National Museum) to a reconstructed kabuki theater (in the Edo-Tokyo Museum).",
        "Wellington, the capital of New Zealand, sits near the North Island’s southernmost point on the Cook Strait. A compact city, it encompasses a waterfront promenade, sandy beaches, a working harbour and colourful timber houses on surrounding hills. From Lambton Quay, the iconic red Wellington Cable Car heads to the Wellington Botanic Gardens. Strong winds through the Cook Strait give it the nickname Windy Wellington.",
        "Sydney, capital of New South Wales and one of Australia's largest cities, is best known for its harbourfront Sydney Opera House, with a distinctive sail-like design. Massive Darling Harbour and the smaller Circular Quay port are hubs of waterside life, with the arched Harbour Bridge and esteemed Royal Botanic Garden nearby. Sydney Tower’s outdoor platform, the Skywalk, offers 360-degree views of the city and suburbs."]
    var cityImages: [UIImage] = [
        UIImage(named: "London.jpg")!,
        UIImage(named: "Phoenix.jpg")!,
        UIImage(named: "Tokyo.jpg")!,
        UIImage(named: "Wellington.jpg")!,
        UIImage(named: "Sydney.jpg")!
    ]
    
    
    
    
    func getCount() -> Int{
        return data.count
    }
    
    func getCityName(i:Int) -> String{
        return data[i]
    }
    func getCityDesc(i:Int) -> String{
        return desc[i]
    }
    func getCityImg(i:Int) -> UIImage{
        return cityImages[i]
    }
    func addCity(city:String, d:String){
        data += [city]
        desc += [d]
        cityImages.append(UIImage(named:"default.jpg")!)
    }
    func removeCity(index: Int){
        data.remove(at: index)
        desc.remove(at: index)
        cityImages.remove(at: index)
    }
}
