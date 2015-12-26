#!/usr/bin/env python3

import os
from urllib.parse import parse_qs
import traceback

def start_response(content_type="text/html", status_code=("200", "OK",)):
    print('Status: %s %s' % (status_code))
    print("Content-Type: %s" % content_type)
    print()

if __name__ == "__main__":
    try:
        
        data = parse_qs(os.environ["QUERY_STRING"])
        
        assert "yo" in data, "Must pass parameter 'yo' in query string"
        
        start_response()
        print("you passed: ?yo=%s" % data["yo"][0])
        
    except Exception as e:
        start_response(status_code=('500', "you fucked up"))
        tb = traceback.format_exc()
        print('<pre>{}</pre>'.format(tb))
