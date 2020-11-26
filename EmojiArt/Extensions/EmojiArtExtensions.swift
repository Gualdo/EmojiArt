//
//  EmojiArtExtensions.swift
//  EmojiArt
//
//  Created by De La Cruz, Eduardo on 25/11/2020.
//

import SwiftUI

extension Collection where Element: Identifiable {
    
    func firstIndex(matching element: Element) -> Self.Index? {
        return firstIndex(where: { $0.id == element.id })
    }
    
    func contains(matching element: Element) -> Bool {
        self.contains(where: { $0.id == element.id })
    }
}

extension URL {
    
    var imageURL: URL {
        //Check to see if there is an embedded imgURL reference
        for query in query?.components(separatedBy: "&") ?? [] {
            let queryComponents = query.components(separatedBy: "=")
            if queryComponents.count == 2 {
                if queryComponents[0] == "imgurl", let url = URL(string: queryComponents[1].removingPercentEncoding ?? "") {
                    return url
                }
            }
        }
        return self.baseURL ?? self
    }
}

extension GeometryProxy {
    
    func convert(_ point: CGPoint, from coordinateSpace: CoordinateSpace) -> CGPoint {
        let frame = self.frame(in: coordinateSpace)
        return CGPoint(x: point.x - frame.origin.x, y: point.y - frame.origin.y)
    }
}

extension Array where Element == NSItemProvider {
    
    func loadObjects<T>(ofType theType: T.Type, firstOnly: Bool = false, using load: @escaping (T) -> Void) -> Bool where T: NSItemProviderReading {
        if let provider = self.first(where: { $0.canLoadObject(ofClass: theType) }) {
            provider.loadObject(ofClass: theType) { object, error in
                if let value = object as? T {
                    DispatchQueue.main.async {
                        load(value)
                    }
                }
            }
            return true
        }
        return false
    }
    
    func loadObjects<T>(ofType theType: T.Type, firstOnly: Bool = false, using load: @escaping (T) -> Void) -> Bool where T: _ObjectiveCBridgeable, T._ObjectiveCType: NSItemProviderReading {
        if let provider = self.first(where: { $0.canLoadObject(ofClass: theType) }) {
            let _ = provider.loadObject(ofClass: theType) { object, error in
                if let value = object {
                    DispatchQueue.main.async {
                        load(value)
                    }
                }
            }
            return true
        }
        return false
    }
    
    func loadFirstObject<T>(ofType theType: T.Type, using load: @escaping (T) -> Void) -> Bool where T: NSItemProviderReading {
        self.loadObjects(ofType: theType, firstOnly: true, using: load)
    }
    
    func loadFirstObject<T>(ofType theType: T.Type, using load: @escaping (T) -> Void) -> Bool where T: _ObjectiveCBridgeable, T._ObjectiveCType: NSItemProviderReading {
        self.loadObjects(ofType: theType, firstOnly: true, using: load)
    }
}

extension Data {
    
    var utf8: String? { String(data: self, encoding: .utf8) }
}

extension CGPoint {
    
    static func -(lhs: Self, rhs: Self) -> CGSize {
        return CGSize(width: lhs.x - rhs.x, height: lhs.y - rhs.y)
    }
    
    static func +(lhs: Self, rhs: CGSize) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.width, y: lhs.y + rhs.height)
    }
    
    static func -(lhs: Self, rhs: CGSize) -> CGPoint {
        CGPoint(x: lhs.x - rhs.width, y: lhs.y - rhs.height)
    }
    
    static func *(lhs: Self, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    
    static func /(lhs: Self, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }
}

extension DragGesture.Value {
    
    var distance: CGSize { location - startLocation }
}

extension CGSize {
    
    static func +(lhs: Self, rhs: Self) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    
    static func -(lhs: Self, rhs: Self) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }
    
    static func *(lhs: Self, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }
    
    static func /(lhs: Self, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
    }
}
