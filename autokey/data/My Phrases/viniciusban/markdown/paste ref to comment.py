# Enter script code

message = "[(comment)](<cursor>)"
keyboard.send_keys("[(comment)](")
keyboard.send_keys("<ctrl>+V")
time.sleep(0.2)
keyboard.send_keys(")")
