<CODEGEN_FILENAME><Structure_name>_LookupView.CodeGen.xaml.dbl</CODEGEN_FILENAME>
;//****************************************************************************
;//
;// Title:       Symphony_LookupView_code.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Template to provide lookup view code behind
;//
;// Author:      Richard C. Morris, Synergex Professional Services Group
;//
;// Copyright (c) 2012, Synergex International, Inc. All rights reserved.
;//
;// Redistribution and use in source and binary forms, with or without
;// modification, are permitted provided that the following conditions are met:
;//
;// * Redistributions of source code must retain the above copyright notice,
;//   this list of conditions and the following disclaimer.
;//
;// * Redistributions in binary form must reproduce the above copyright notice,
;//   this list of conditions and the following disclaimer in the documentation
;//   and/or other materials provided with the distribution.
;//
;// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;// POSSIBILITY OF SUCH DAMAGE.
;//
;//****************************************************************************
;;****************************************************************************
;;
;; WARNING: This code was generated by CodeGen. Any changes that you
;;          make to this code will be overwritten if the code is regenerated!
;;
;; Template author:	Richard C. Morris, Synergex Professional Services Group
;;
;; Template Name:	Symphony Framework : <TEMPLATE>.tpl
;;
;;****************************************************************************
import System
import System.Collections.Generic
import System.Linq
import System.Text
import System.Windows
import System.Windows.Controls
import System.Windows.Data
import System.Windows.Documents
import System.Windows.Input
import System.Windows.Media
import System.Windows.Media.Imaging
import System.Windows.Navigation
import System.Windows.Shapes

namespace <NAMESPACE>

	;;; <summary>
	;;; Interaction logic for <Structure_name>_LookupView.xaml
	;;; </summary>
	public partial class <Structure_name>_LookupView extends UserControl

		public method <Structure_name>_LookupView
			endparams
		proc
			this.InitializeComponent()
		endmethod
	endclass
endnamespace

