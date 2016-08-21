def ComputerUnitsToByte(capacity, unit):
	unit = unit.upper()
	h = {"KB":1024, "MB":1048576, "G":1073741824, "TB":1099511627776, "P":1125899906842624}
	return str(capacity * h[unit])