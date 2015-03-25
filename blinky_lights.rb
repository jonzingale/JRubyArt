		def setup
			# width,height
			size(800,800)
			@bs = 150 # boardsize (150 for size 800)
			@board = rand_board ; @i = 0 ; background(0)
			frame_rate 2 # what ratio is there for frame_rate, board_size and e_size?
		end

		def pretty_print(board)
			e_size = 5 # size of augmentation
			board.each_with_index do |row,c_dex|
				row.each_with_index do |c,r_dex| # original game
					params = [r_dex,c_dex].map{|i|i*e_size+20} + [e_size]*2
					rgb = (1..3).map{|i| c*(rand 255)}
					fill(*rgb) ; ellipse(*params)
				end
			end
		end
		
		def rand_board ; (0...@bs).map{|i| (0...@bs).map{|j| rand(2)} } ; end
		def cell_at(row,col,board) ; board[row][col] ; end
		
		def neighborhood(row,col,board) # better way to rid of [0,0] ? 
			nears = (-1..1).inject([]){|is,i| is + (-1..1).map{|j| [i,j]} }
			nears = nears.select{|i| i!=[0,0]}
			nears.map{|ns| n,m = ns ; cell_at((row+n) % @bs,(col+m) % @bs,board) }
		end
			
		def blink(state,neigh)
			sum = neigh.inject :+
			sum == 3 ? 1 : (sum==2&&state==1) ? 1 : 0 
		end	
		
		def blink_once(board)
			b,bs = [:take,:drop].map{|f| board.send(f,@bs)}
			board.empty? ? [] : blink_once(bs).unshift(b)
		end

		def go_team(board)
			beers = (0...@bs).inject([]){|is,i| is + (0...@bs).map{|j| [i,j]} }
			b_row=beers.map do |xy|
				b_params = xy << board
				blink(cell_at(*b_params),neighborhood(*b_params))
			end ; blink_once(b_row)
		end

		def draw
			@i = (@i+1) % @bs
			pretty_print(@board)
			@board = go_team(@board)
		end
