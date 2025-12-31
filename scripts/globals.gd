extends Node

func shorten_number(num):
	if num > 999_999_999_999:
		return str(int(num / 1_000_000_000_0) / 100.0) + "T¢"
	elif num > 999_999_999:
		return str(int(num / 1_000_000_0) / 100.0) + "B¢"
	elif num > 999_999:
		return str(int(num / 1_000_0) / 100.0) + "M¢"
	elif num > 999:
		return str(int(num / 10.0) / 100.0) + "K¢"
	else:
		return str(num) + "¢"
		
