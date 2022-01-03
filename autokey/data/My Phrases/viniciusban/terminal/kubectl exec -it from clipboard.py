# Enter script code

message = "kubectl exec -it <cursor> -- bash"
keyboard.send_keys("kubectl exec -it ")
keyboard.send_keys("<shift>+<ctrl>+v")
time.sleep(0.1)
keyboard.send_keys(" -- bash")
