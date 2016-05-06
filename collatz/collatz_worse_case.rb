ARY = [0.5,0.3333333333333333,0.8,0.75,0.6923076923076923,0.6666666666666666,
			0.6470588235294118,0.6363636363636364,0.6292134831460674,0.625,
			0.6223175965665236,0.6206896551724138,0.6196721311475409,
			0.6190476190476191,0.6186599874765185,0.618421052631579,
			0.6182731403970342,0.6181818181818182,0.6181253425909008,
			0.6180904522613065,0.6180688836933385,0.6180555555555556,
			0.6180473175608131,0.6180422264875239,0.6180390799213922,
			0.6180371352785146,0.6180359334071007,0.6180351906158358,
			0.6180347315432503,0.6180344478216818,0.6180342724717682,
			0.6180341640996919,0.6180340971220156,0.6180340557275542]
			# 0.3819660526445746 <-- not likely though hard limit

WorstCase = [0,0,1,5,13,29,61,125,253,509,1021,2045,4093,8189,16381,32765,65533,
						131069,262141,524285,1048573,2097149,4194301,8388605,16777213,
						33554429,67108861,134217725,268435453,536870909,1073741821,
						2147483645,4294967293,8589934589]#,8589934591,8589934592]

X_INC = ARY.length.to_f
ABVk = 10**6
ABVM = 10**9

def setup
	size displayWidth, displayHeight
	text_font create_font("SanSerif",10)
	colorMode(HSB,360,100,100)
	frame_rate 10
	background 0
	to_points
	to_lines
	plot_points

	phiMinusOne
end

def phiMinusOne # φ - 1
	stroke 200, 100, 100
	phiMinus = height * (3 - 5**0.5)/2.0
	line(0, phiMinus, width, phiMinus)
end

def to_points
	fill 200, 100, 100
	@pts = ARY.map.with_index do |val, t|
		y_val = height * (1 - val)
		x_val = 10 + t * width / X_INC
		[x_val, y_val]
	end
	@pts.each{|pt| ellipse(*pt, 10, 10)}
end

def plot_points
	stroke 140, 100, 100 # 1 048 573
	WorstCase.zip(@pts).each do |n,(x,y)|
		num = n > ABVM ? "#{n/10**6} M" : 
					n > ABVk ? "#{n/10**3} k" : "#{n}"
		text(num,x,y-10)

	end
end

def to_lines
	stroke(140,100,100)
	@lines, @i = [], 0

	while @i < X_INC-1
		line(*@pts[@i],*@pts[@i+1]) ; @i += 1
	end
end
