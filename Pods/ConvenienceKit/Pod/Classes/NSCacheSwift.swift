//
//  NSCacheSwift.swift
//  ConvenienceKit
//
//  Created by Benjamin Encz on 6/4/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

import Foundation

open class NSCacheSwift<T: Hashable, U> {
  
  fileprivate let cache: NSCache<AnyObject, AnyObject>
  
  open var delegate: NSCacheDelegate? {
    get {
      return cache.delegate
    }
    set {
      cache.delegate = delegate
    }
  }
  
  open var name: String {
    get {
      return cache.name
    }
    set {
      cache.name = name
    }
  }
  
  open var totalCostLimit: Int {
    get {
      return cache.totalCostLimit
    }
    set {
      cache.totalCostLimit = totalCostLimit
    }
  }
  
  open var countLimit: Int {
    get {
      return cache.countLimit
    }
    set {
      cache.countLimit = countLimit
    }
  }
  
  open var evictsObjectsWithDiscardedContent: Bool {
    get {
      return cache.evictsObjectsWithDiscardedContent
    }
    set {
      cache.evictsObjectsWithDiscardedContent = evictsObjectsWithDiscardedContent
    }
  }
  
  public init() {
    cache = NSCache()
  }
  
  open func objectForKey(_ key: T) -> U? {
    let key: AnyObject = replaceKeyIfNeccessary(key)

    let value = cache.object(forKey: key) as? U
      ?? (cache.object(forKey: key) as? Container<U>)?.content
    
    return value
  }

  open func setObject(_ obj: U, forKey key: T) {
    let object: AnyObject = obj as? AnyObject ?? Container(content: obj)
    let key: AnyObject = replaceKeyIfNeccessary(key)
    
    cache.setObject(object, forKey: key)
  }
  
  open func setObject(_ obj: U, forKey key: T, cost g: Int) {
    cache.setObject(obj as AnyObject, forKey: key as AnyObject, cost: g)
  }
  
  open func removeObjectForKey(_ key: T) {
    let key: AnyObject = replaceKeyIfNeccessary(key)
    cache.removeObject(forKey: key)
  }
  
  open func removeAllObjects() {
    cache.removeAllObjects()
  }
  
  open subscript(key: T) -> U? {
    get {
      return objectForKey(key)
    }
    set(newValue) {
      if let newValue = newValue {
        setObject(newValue, forKey: key)
      }
    }
  }
  
  // MARK: Wrapping Value Types into Reference Type Containers
  
  /*
    NSCache can only store types that conform to AnyObject. It compares keys by object identity.    To allow value types as keys, NSCacheSwift requires keys to conform to Hashable.    NSCacheSwift then creates an NSObject for each unique value (as determined by equality) that acts as the key in NSCache.
  */
  fileprivate var keyReplacers = [T : NSObject]()
  
  fileprivate func replaceKeyIfNeccessary(_ originalKey :T) -> AnyObject {
    let key: AnyObject? = originalKey as? AnyObject ?? keyReplacers[originalKey]
    
    if let key: AnyObject = key {
      return key
    } else {
      let container = NSObject()
      keyReplacers[originalKey] = container
      
      return container
    }
  }
  
}

private class Container<T> {
  fileprivate (set) var content: T
  
  init(content: T) {
    self.content = content
  }
}
