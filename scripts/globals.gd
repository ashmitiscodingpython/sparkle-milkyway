extends Node

var alphas = ["K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc", "Udc", "Ddc", "Tdc", "Qadc", "Qidc", "Sxdc", "Spdc", "Ocdc", "Nmdc", "Vg", "Uvg", "Dvg", "Tvg", "Qavg", "Qivg", "Sxvg", "Spvg", "Ovg", "Nvg", "Tg", "Utg", "Dtg"]

func _ready() -> void:
	pass

func check(num, power, alpha):
	if pow(10, power + 3) > num and float(num) >= pow(10, power):
		return str(int(num / pow(10, power - 2)) / 100.0) + alpha + "¢"
	else:
		return false

func shorten_number(num):
	if num < 1000:
		return str(num) + "¢"
	for i in range(34):
		var checked = check(num, (i + 1) * 3, alphas[i])
		if checked:
			return checked
	return str((num / pow(10, 98)) / 100.0) + "G¢"
		
