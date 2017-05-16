
All communication between the "Host" (our SDK) and the "Client" (our JS code) is with
JSON objects that require two top-level keys: "function" and "payload".  As an example:

   {
      "function": "sync",
      "payload": {
            "supports": {
                  "sms": true,
                  "tel": true,
                  "cal": false
            }
   }
                           
                        
