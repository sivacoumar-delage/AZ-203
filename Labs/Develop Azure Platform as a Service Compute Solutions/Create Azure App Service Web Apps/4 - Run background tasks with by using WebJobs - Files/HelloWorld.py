#!/usr/bin/env python
import datetime

now = datetime.datetime.now()
print("Hello World from Python ! Today is " + now.strftime("%Y-%m-%d") + " and it's " + now.strftime("%H:%M:%S") + " !")
