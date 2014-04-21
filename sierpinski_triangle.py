MAX_RECURSION = 8

class Point(object):
	def __init__(self, x, y):
		self.x = x
		self.y = y

	def __str__(self):
		return '(' + str(self.x) + ', ' + str(self.y) + ')'

	def get_wx_point(self):
		return (self.x, self.y)

	def translate(self, p2):
		#adds the coordinates of the two points
		self.x = self.x + p2.x
		self.y = self.y + p2.y

class Line(object):
	def __init__(self, p1, p2):
		self.p1 = p1
		self.p2 = p2

	def midpoint(self):
		x = (self.p1.x + self.p2.x) / 2
		y = (self.p1.y + self.p2.y) / 2
		return Point(x, y)

	def __str__(self):
		return str(self.p1) + ', ' + str(self.p2)

	def get_wx_point(self):
		return [ self.p1.get_wx_point(), self.p2.get_wx_point() ]

	def translate(self, p):
		self.p1.translate(p)
		self.p2.translate(p)

class Triangle(object):
	def __init__(self, p1, p2, p3):
		self.p1 = p1
		self.p2 = p2
		self.p3 = p3

	def sub_triangle(self):
		l1 = Line(self.p1, self.p2)
		l2 = Line(self.p2, self.p3)
		l3 = Line(self.p3, self.p1)
		np1 = l1.midpoint()
		np2 = l2.midpoint()
		np3 = l3.midpoint()
		return Triangle(np1, np2, np3)

	def __str__(self):
		return str(self.p1) + '\n' + str(self.p2) + '\n' + str(self.p3)

	def get_wx_point(self):
		ret = []
		ret.append( self.p1.get_wx_point() )
		ret.append( self.p2.get_wx_point() )
		ret.append( self.p3.get_wx_point() )
		return ret

	def translate(self, p):
		self.p1.translate(p)
		self.p2.translate(p)
		self.p3.translate(p)

class Sierpinski_Triangle(object):
	def __init__(self, max_size=100):
		self.current_iteration = 1
		p1 = Point(0, 0)
		p2 = Point(max_size, 0)
		p3 = Point(max_size/2, max_size)
		self.current_triangles = [ Triangle(p1, p2, p3) ]

	def step(self):
		if self.current_iteration > MAX_RECURSION:
			pass
		else:
			next_state = []
			for tri in self.current_triangles:
				p1 = tri.p1
				p2 = tri.p2
				p3 = tri.p3
				next_state.append( Triangle( p1, Line(p1, p2).midpoint(), Line(p1, p3).midpoint() ) )
				next_state.append( Triangle( p2, Line(p2, p3).midpoint(), Line(p2, p1).midpoint() ) )
				next_state.append( Triangle( p3, Line(p3, p1).midpoint(), Line(p3, p2).midpoint() ) )
			self.current_triangles = next_state
			self.current_iteration += 1

	def __str__(self):
		ret = ''
		for tri in self.current_triangles:
			ret += str( tri ) + '\n\n'
		return ret

	def get_wx_point(self):
		ret = []
		for tri in self.current_triangles:
			ret.append( tri.get_wx_point() )
		return ret

	def translate(self, p):
		for i in range(len(self.current_triangles)):
			self.current_triangles[i].translate(p)

st = Sierpinski_Triangle(200)
