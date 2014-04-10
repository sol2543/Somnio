#!/usr/bin/python
# -*- coding: utf-8 -*-

# center.py

import wx

APP_EXIT = 1
now_playing = 'np.png'

class sMain(wx.Frame):
  
	def __init__(self, *args, **kwargs):
        	super(sMain, self).__init__(*args, **kwargs) 
            
		self.mainUI()
        
	def mainUI(self):

		sMenu = wx.MenuBar()
		npPanel = wx.Panel(self)
		np1 = wx.Image(now_playing, wx.BITMAP_TYPE_ANY).ConvertToBitmap()
		self.bitmap1 = wx.StaticBitmap(self, -1, np1, (55, 30))	
		sFileMenu = wx.Menu()
		sAboutHelpMenu = wx.Menu()
		quitSomnio = wx.MenuItem(sFileMenu, APP_EXIT, '&Quit Somnio\tCtrl+C')
		aboutSomnio = wx.MenuItem(sAboutHelpMenu, wx.ID_ABOUT, '&About')
		helpSomnio = wx.MenuItem(sAboutHelpMenu, wx.ID_HELP, '&Help')
		
		sAboutHelpMenu.AppendItem(aboutSomnio)
		sFileMenu.AppendSeparator()
		sAboutHelpMenu.AppendItem(helpSomnio)
		sFileMenu.AppendItem(quitSomnio)
	
		self.Bind(wx.EVT_MENU, self.helpMessage, helpSomnio)
		self.Bind(wx.EVT_MENU, self.aboutMessage, aboutSomnio)
		self.Bind(wx.EVT_MENU, self.OnQuit, id=APP_EXIT)

		sMenu.Append(sFileMenu, '&File')
		sMenu.Append(sAboutHelpMenu, '&Info')
		self.SetMenuBar(sMenu)	
		self.SetSize(wx.Size(260,260))    
		self.Centre()
		self.Show()
        
	def OnQuit(self, e):
		self.Close()

	def helpMessage(self, event):
		hDialog = wx.MessageDialog(self, 'This is the help dialog', 'Help', wx.OK)
		hDialog.ShowModal()
		hDialog.Destroy()

	def aboutMessage(self, event):
		hDialog = wx.MessageDialog(self, 'This is the ABOUT dialog', 'About', wx.OK)
                hDialog.ShowModal()
                hDialog.Destroy()

def main():

	sMainGUI = wx.App()
	sMain(None, title='Somnio')
	sMainGUI.MainLoop()

if __name__ == '__main__':
 
	main() 
