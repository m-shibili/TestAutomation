#Boa:Dialog:Dlgtoolcheck
# -*- coding: utf-8 -*-

import wx

[wxID_DLGTOOLCHECK, wxID_DLGTOOLCHECKBUTTON_CANCEL, wxID_DLGTOOLCHECKBUTTON_OK,
wxID_DLGTOOLCHECKSTATICTEXT1,
] = wx.NewIdRef(4)

class Dlgtoolcheck(wx.Dialog):

    def __init__(self, parent, aTestStep):
        wx.Dialog.__init__(self, id=wxID_DLGTOOLCHECK, name='', parent=parent,
                           pos=wx.Point(407, 488), size=wx.Size(364, 193),
                           style=wx.DEFAULT_DIALOG_STYLE | wx.RESIZE_BORDER, title='toolcheck')

        self.SetClientSize(wx.Size(356, 159))
        self.SetToolTip('Cancel')

        self.sizerMain = wx.BoxSizer(orient=wx.VERTICAL)
        self.sizerButtons = wx.BoxSizer(orient=wx.HORIZONTAL)

        self.button_OK = wx.Button(id=wxID_DLGTOOLCHECKBUTTON_OK, label='OK',
                                   name='button_OK', parent=self, pos=wx.Point(191, 131),
                                   size=wx.Size(75, 23), style=0)
        self.button_OK.SetToolTip('OK')
        self.button_OK.Bind(wx.EVT_BUTTON, self.OnCmdOkButton, id=wxID_DLGTOOLCHECKBUTTON_OK)
        self.sizerButtons.Add(self.button_OK, 0, border=5, flag=wx.ALL)

        self.button_Cancel = wx.Button(id=wxID_DLGTOOLCHECKBUTTON_CANCEL, label='Cancel',
                                       name='button_Cancel', parent=self, pos=wx.Point(276, 131),
                                       size=wx.Size(75, 23), style=0)
        self.button_Cancel.Bind(wx.EVT_BUTTON, self.OnCmdCancelButton,
                                id=wxID_DLGTOOLCHECKBUTTON_CANCEL)
        self.sizerButtons.Add(self.button_Cancel, 0, border=5, flag=wx.ALL)

        self.staticText1 = wx.StaticText(id=wxID_DLGTOOLCHECKSTATICTEXT1,
                                         label='Add your controls for teststep configuration here!',
                                         name='staticText1', parent=self, pos=wx.Point(0, 0),
                                         size=wx.Size(356, 126), style=0)
        self.staticText1.Center(wx.BOTH)
        self.sizerMain.Add(self.staticText1, 1, border=0, flag=wx.EXPAND)
        self.sizerMain.Add(self.sizerButtons, 0, border=0, flag=wx.ALIGN_CENTER)

        self.SetSizer(self.sizerMain)

        self.theTestStep = aTestStep
        ##Add your code to init controls from self.theTestStep here

    def IsDialogModal(self):
        # This indicates that the dialog should be opened as modal dialog. Thus, the dialog shall 
        # be closed calling self.EndModal(result) as implemented below.
        return True

    def OnCmdCancelButton(self, event):
        ##Add your code here
        self.EndModal(wx.ID_CANCEL)

    def OnCmdOkButton(self, event):
        ##Add your code to update self.theTestStep here
        self.EndModal(wx.ID_OK)

##Add your required functions here