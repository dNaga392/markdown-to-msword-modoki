''''
'''' Markdown to Word�R���o�[�^�[ ���H�i
'''' �X�^�C���͗\�ߕ����ɑg�ݍ��܂�Ă������Ƃ���B
'''' Author kiyo-hiko
'''' Since 2015. 2.17
''''
''' Markdown�Ă��ȃe�L�X�g�t�@�C����ǂ�ŏ����t��Word�����ɕϊ��B
Sub ReadMDLikeText()
    Dim dlg: Set dlg = Application.FileDialog(msoFileDialogOpen)
    With dlg.Filters
        .Clear
        .Add "�e�L�X�g�t�@�C��", "*.txt", 1
    End With
    If dlg.Show = -1 Then
        Dim f: For Each f In dlg.SelectedItems
            Open f For Input As #1
            Do Until EOF(1)
                Dim l: Line Input #1, l
                l = ApplyFormat(l)
                Selection.TypeText Text:=l & vbCrLf
            Loop
            Close #1
        Next f
    End If
End Sub

''' �s�P�ʂ̏����ݒ�͂���ł��B�ϊ����\�b�h���剻���������Ȃ����B
Function ApplyFormat(l)
    With Selection
        If False Then
            MsgBox 1
        ElseIf Left(l, 4) = "### " Then
            .Paragraphs.Style = ActiveDocument.Styles("���o��3")
            ApplyFormat = Mid(l, 5)
        ElseIf Left(l, 3) = "## " Then
            .Paragraphs.Style = ActiveDocument.Styles("���o��2")
            ApplyFormat = Mid(l, 4)
        ElseIf Left(l, 2) = "# " Then
            .Paragraphs.Style = ActiveDocument.Styles("���o��1")
            ApplyFormat = Mid(l, 3)
        ElseIf Left(l, 1) = ">" Then
            .Paragraphs.Style = ActiveDocument.Styles("���p")
            ApplyFormat = Mid(l, 2)
        ElseIf Left(l, 3) = "** " Then ' �ԍ��Ȃ����X�g�F���x��2
            .Range.SetListLevel Level:=2
            ApplyFormat = Mid(l, 3)
        ElseIf Left(l, 2) = "* " Then ' �ԍ��Ȃ����X�g�F���x��1
            .Range.SetListLevel Level:=1
            .Range.ListFormat.ApplyListTemplateWithLevel _
                ListTemplate:=ListGalleries(wdBulletGallery).ListTemplates(1), _
                ContinuePreviousList:=False, _
                ApplyTo:=wdListApplyToWholeList, _
                DefaultListBehavior:=wdWord10ListBehavior
            ApplyFormat = Mid(l, 3)
        ElseIf Left(l, 3) = "1. " Then ' �ԍ��t�����X�g�F���̂Ƃ���A�Ԃɂł��Ȃ�
            .Range.ListFormat.ApplyListTemplateWithLevel _
                ListTemplate:=ListGalleries(wdNumberGallery).ListTemplates(7), _
                ContinuePreviousList:=False, _
                ApplyTo:=wdListApplyToWholeList, _
                DefaultListBehavior:=wdWord10ListBehavior
            ApplyFormat = Mid(l, 4)
        ElseIf l = "***" Then ' �������F�Ȃ񂩃G���[�o��̂Ŏ����ł��ĂȂ�
            ' With .Paragraphs.Borders(wdBorderBottom)
            '     .LineStyle = wdLineStyleSingle
            '     .Color = Options.DefaultBorderColor
            ' End With
            ApplyFormat = ""
        Else
            .Paragraphs.Style = ActiveDocument.Styles("�W��")
            ApplyFormat = l
        End If
    End With
End Function
