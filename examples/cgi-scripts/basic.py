#!/usr/bin/env python3

import cgitb
cgitb.enable()
from nexus.cgi import start_response, parse_qs


if __name__ == "__main__":
    start_response()
    data = parse_qs()
    assert "yo" in data, "Must pass parameter 'yo' in query string"
    print("you passed: ?yo=%s" % data["yo"])
