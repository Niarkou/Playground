import RPi.GPIO as GPIO
import time

red = 11
green = 40
blue = 33

GPIO.setmode(GPIO.BOARD)
GPIO.setup(red, GPIO.OUT)
GPIO.output(red, GPIO.LOW)
GPIO.setup(blue, GPIO.OUT)
GPIO.output(blue, GPIO.LOW)
GPIO.setup(green, GPIO.OUT)
GPIO.output(green, GPIO.LOW)

while True:
	GPIO.output(blue, GPIO.LOW)
	GPIO.output(red, GPIO.HIGH)
	time.sleep(1)
	GPIO.output(red, GPIO.LOW)
	GPIO.output(green, GPIO.HIGH)
	time.sleep(1)
	GPIO.output(green, GPIO.LOW)
	GPIO.output(blue, GPIO.HIGH)
	time.sleep(1)