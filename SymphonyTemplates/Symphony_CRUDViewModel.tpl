<CODEGEN_FILENAME><Structure_name>_CRUDViewModel.CodeGen.dbc</CODEGEN_FILENAME>
<OPTIONAL_USERTOKEN>SYMPHONY_ALLOW_REMOVE=true</OPTIONAL_USERTOKEN>
<OPTIONAL_USERTOKEN>SYMPHONY_ALLOW_ADD=true</OPTIONAL_USERTOKEN>
<OPTIONAL_USERTOKEN>SYMPHONY_ALLOW_MODIFY=true</OPTIONAL_USERTOKEN>
;//****************************************************************************
;//
;// Title:       Symphony_CRUDViewModel.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Template to provide CRUD maintenance view model code
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
import System.Text
import System.Windows

import Symphony.Conductor.ViewModel
import Symphony.Conductor.DataIO

<FILEIFEXIST:TPLINC:namespace.inc>

namespace <NAMESPACE>

	public partial class <Structure_name>_CrudViewModel extends CRUDViewModel

		public method <Structure_name>_CrudViewModel
			sender					,@FrameworkElement
			endparams
			parent(sender, new <Structure_name>_Data(), new <Structure_name>_Data())
		proc
			;;create our data IO object
			mAppLogic = new <Structure_name>_CRUDAppLogic()

			;;handle data IO operations.
			addhandler(this.IOLocateFirstItem, mAppLogic.ReadFirstRecord)
			addhandler(this.IOLocateNextItem, mAppLogic.ReadNextRecord)
			addhandler(this.IOLocatePreviousItem, mAppLogic.ReadPrevRecord)
			addhandler(this.IOLocateLastItem, mAppLogic.ReadLastRecord)
			addhandler(this.IOLocateItem, mAppLogic.ReadRecord)
			addhandler(this.IOSaveItem, mAppLogic.UpdateRecord)
			addhandler(this.IOCreateItem, mAppLogic.AddRecord)
			addhandler(this.IODeleteItem, mAppLogic.RemoveRecord)

			;;set user defaults
			IsRemoveCommandAvailable = <SYMPHONY_ALLOW_REMOVE>
			IsAddCommandAvailable = <SYMPHONY_ALLOW_ADD>
			IsModifyCommandAvailable = <SYMPHONY_ALLOW_MODIFY>

			;;create lookup/listview models
			m<Structure_name>ListVM = new <Structure_name>_ListViewModel()
			addhandler(m<Structure_name>ListVM.ItemSelected, <Structure_name>ListItemSelected)

			<FIELD_LOOP>
			<IF DRILL>
			.ifdef <Field_drillm>_ListViewModel
			m<Field_drillm>DrillVM = new <Field_drillm>_ListViewModel()
			addhandler(m<Field_drillm>DrillVM.ItemSelected, <Field_drillm>DrillItemSelected)
			.endc
			</IF DRILL>
			</FIELD_LOOP>

			;;need to handle field focus, etc
			addhandler(StoryBoardComplete, animationComplete_event)
		endmethod

		private mAppLogic	,@<Structure_name>_CRUDAppLogic

.region "code generated lookup view models"

		private m<Structure_name>ListVM	,@<Structure_name>_ListViewModel

		public property <Structure_name>ListVM, @<Structure_name>_ListViewModel
			method get
			proc
				mreturn m<Structure_name>ListVM
			endmethod
		endproperty

		private method <Structure_name>ListItemSelected, void
			in req sender						,@SelectedItemEventArgs
			endparams
		proc
			this.RestoreBaseState()
			this.PrimaryData.SynergyRecord = sender.ItemValue.SynergyRecord
			this.ProcessDataComplete(PrimaryData, "DataEntryState")
		endmethod

		<FIELD_LOOP>
		<IF DRILL>
		.ifdef <Field_drillm>_ListViewModel
		private m<Field_drillm>DrillVM	,@<Field_drillm>_ListViewModel

		public property <Field_drillm>DrillVM, @<Field_drillm>_ListViewModel
			method get
			proc
				mreturn m<Field_drillm>DrillVM
			endmethod
		endproperty

		private method <Field_drillm>DrillItemSelected, void
			in req sender						,@SelectedItemEventArgs
			endparams
		proc
			;TODO ((@Part_Data)MasterData).<Field_name> = ((@<Field_drillm>_Data)sender.ItemValue).Group_id
			this.StateCompleted()

		endmethod
		.endc
		</IF DRILL>
		</FIELD_LOOP>
.endregion

		;;when the visual state animation has completed this event handler will be executed.
		;;Here you can now set the required focus.
		private method animationComplete_event, void
			endparams
		proc
			using this.CurrentStateName select
			("KeyEntryState"),
			begin
				data tmpDO	,@<Structure_name>_Data
				tmpDO = (@<Structure_name>_Data)PrimaryData

				;;focus the first field
				<PRIMARY_KEY>
				<SEGMENT_LOOP>
				<FIRST_SEGMENT>
				tmpDO.<Segment_name>IsFocused = true
				</FIRST_SEGMENT>
				</SEGMENT_LOOP>
				</PRIMARY_KEY>

				CurrentProgramMode = ProgramMode.keyEntry
				configureCommands()
			end
			("DataEntryState"),
			begin
				data tmpDO	,@<Structure_name>_Data
				tmpDO = (@<Structure_name>_Data)MasterData
				if (CurrentProgramMode == ProgramMode.Add) then
				begin
					<PRIMARY_KEY>
					<SEGMENT_LOOP>
					tmpDO.<Segment_name>IsEnabled = true
					</SEGMENT_LOOP>
					</PRIMARY_KEY>
					;;focus the first field
					<PRIMARY_KEY>
					<SEGMENT_LOOP>
					<FIRST_SEGMENT>
					tmpDO.<Segment_name>IsFocused = true
					</FIRST_SEGMENT>
					</SEGMENT_LOOP>
					</PRIMARY_KEY>
				end
				else
				begin
					CurrentProgramMode = ProgramMode.Modify
					<PRIMARY_KEY>
					<SEGMENT_LOOP>
					tmpDO.<Segment_name>IsEnabled = false
					</SEGMENT_LOOP>
					</PRIMARY_KEY>
;					need to focus the first non-key field
				end
				configureCommands()
			end
			("PrimaryLookupState"),
			begin
				CurrentProgramMode = ProgramMode.Lookup
				if (DataFileUpdated == true .and. m<Structure_name>ListVM.ResultsTable.Count > 0)
				begin
					DataFileUpdated = false
					m<Structure_name>ListVM.ProcessSearchRequest()
				end
				configureCommands()
			end
			<FIELD_LOOP>
			<IF DRILL>
			.ifdef <Field_drillm>_ListViewModel
			("<FIELD_DRILLM>DrillState"),
			begin
				<Field_drillm>DrillVM.ResultsTable.Clear()
				CurrentProgramMode = ProgramMode.Drill
				configureCommands()
			end
			.endc
			</IF DRILL>
			</FIELD_LOOP>
			endusing
		endmethod

	endclass


endnamespace


