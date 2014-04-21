from bufferedcanvas import *
from sierpinski_triangle import *
import wx
import os
import sys
import time
import threading

class Triangle(BufferedCanvas):
	def __init__(self, parent, ID=-1):
		#height = wx.DisplaySize()[1]
		#width = wx.DisplaySize()[0]
		height = 500
		width = 500
		self.st = Sierpinski_Triangle(height)
		move_point = Point( abs(width - height) / 2, 0 )
		self.st.translate(move_point)

		BufferedCanvas.__init__(self, parent, ID)

	def draw(self, dc):
		dc.SetBackground(wx.Brush("ORANGE"))
		dc.Clear()

		dc.SetBrush(wx.Brush(wx.WHITE))
		dc.DrawPolygonList(self.st.get_wx_point())

	def Increment(self):
		self.st.step()
		self.update()

class TriangleApp(wx.App):
	def OnInit(self):
		self.frame = TriangleFrame(None)
		self.frame.Show()
		return True

class TriangleFrame(wx.Frame):
	def __init__(self, parent):
		wx.Frame.__init__(self, parent, title="Sierpinski Visualization")
		#self.ShowFullScreen(True, style=wx.FULLSCREEN_ALL)
		self.SetSize(wx.Size(500,500))
		self.triangle_canvas = Triangle(self)

		sizer = wx.BoxSizer(wx.VERTICAL)
		sizer.Add(self.triangle_canvas, 1, wx.EXPAND)
		self.SetSizer(sizer)

		incTime = os.environ["divValue"] #the total timer length divided by 10
		timLength = os.environ["timerLength"] #the total timer length
		newInc = int(incTime)
		newTotalTime = int(timLength)
		newTimeFinal = newInc * 60 #converting timer div value to seconds		
		def incAction():
			for i in range(1, 9):
				self.triangle_canvas.Increment()
				time.sleep(newTimeFinal)
		
		threading.Thread(target=incAction).start()

app = TriangleApp(False)
app.MainLoop()
