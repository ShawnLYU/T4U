/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ss.Utility;

import java.util.*;
import org.json.*;

/**
 *
 * @author Steven Mao
 * 
 * 2016040901    SM    Implement jsonToMap
 */

// Reference: http://stackoverflow.com/questions/21720759/convert-a-json-string-to-a-hashmap
public class T4uJson2Map {
    public static HashMap<String, String> jsonToMap(JSONObject jsonObject) throws JSONException {
        HashMap<String, String> retMap = new HashMap<String, String>();
        if (jsonObject != JSONObject.NULL) {
            Iterator<String> keysItr = jsonObject.keys();
            while(keysItr.hasNext()) {
                String key = keysItr.next();
                String value = jsonObject.get(key).toString();
                retMap.put(key, value);
            }
        }
        return retMap;
    }
}
