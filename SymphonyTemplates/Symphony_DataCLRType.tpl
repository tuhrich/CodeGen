<CODEGEN_FILENAME><Structure_name>_Data.CodeGen.dbc</CODEGEN_FILENAME>
<OPTIONAL_USERTOKEN>RPSDATAFILES= </OPTIONAL_USERTOKEN>
<REQUIRES_OPTION>prefix</REQUIRES_OPTION>
;//****************************************************************************
;//
;// Title:       Symphony_Data.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Template to define structure based Data Object
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
;; WARNING: This code was generated by CodeGen. Any changes that you
;;          make to this code will be overwritten if the code is regenerated!
;;
;; Template author: Richard C. Morris, Synergex Professional Services Group
;;
;; Template Name:   Symphony Framework : <TEMPLATE>.tpl
;;
;;***************************************************************************
import System
import System.Collections.Generic
import System.Text

import Symphony.Conductor.Model
import Symphony.Conductor.Converters

import System.Runtime.Serialization
import Newtonsoft.Json

namespace <NAMESPACE>

    ;;define a structure that we can use around the applicaiton

    .include '<structure_noalias>' repository <RPSDATAFILES>, structure = 'STR<Structure_name>', prefix = "str_", end

    {DataContract}
    public partial class <Structure_name>_Data extends Symphony.Conductor.Model.DataObjectBase

	public const RPSStructureName	,String	,"<STRUCTURE_NOALIAS>"

        ;;make the record availalbe and a copy
        .include '<structure_noalias>' repository <RPSDATAFILES>, private record = '<structure_name>_main', prefix = "<FIELD_PREFIX>", end
        .include '<structure_noalias>' repository <RPSDATAFILES>, private record = '<structure_name>_store', prefix = "<FIELD_PREFIX>", end

	private mDoneSynergyRecordValue	,boolean	,true 

	;;use symphony converters
	private mDateConveter		,@SynergyDecimalDateConverter	,new SynergyDecimalDateConverter()
	private mAlphaConveter		,@SynergyAlphaConverter	,new SynergyAlphaConverter()
	private mDecimalConveter	,@SynergyDecimalConverter	,new SynergyDecimalConverter()
	private mImpliedDecimalConveter	,@SynergyImpliedDecimalConverter	,new SynergyImpliedDecimalConverter()
	private mIntegerConveter	,@SynergyIntConverter	,new SynergyIntConverter()

		
        ;;; <summary>
        ;;;  Constructor, initialise the base fields
        ;;; </summary>
        public method <Structure_name>_Data
            endparams
            parent()
        proc
			configureFieldInfo()
			setFieldNames()
			InitData()
			mDoneSynergyRecordValue = false
			extendedConstructor()
        endmethod

        ;;; <summary>
        ;;; Alternate constructor, accepts the inital value to assign to the object
        ;;; </summary>
        ;;; <param name="results">Provide the loaded Excel results object</param>
        public method <Structure_name>_Data
            in req synRec       ,String
            endparams
            parent()
        proc
			mIsNew = false
			configureFieldInfo()
			setFieldNames()
			SynergyRecord = synRec
			OriginalSynergyRecord = synRec
			extendedConstructor()
        endmethod
		
		;;; <summary>
		;;; Alternate constructor, accepts the inital value to assign to the object.
		;;; Also accepts the boolean value to assign to the ObjectRaisesPropertyChanged property.
		;;; </summary>
		;;; <param name="results">Provide the loaded Excel results object.</param>
		;;; <param name="notifyUI">values passed onto the ObjectRaisesPropertyChanged property.</param>
		public method <Structure_name>_Data
			in req synRec       ,String
			in req notifyUI		,DataObjectNotificationState
			endparams
			parent()
		proc
			ObjectRaisesPropertyChanged = notifyUI
			mIsNew = false
			configureFieldInfo()
			setFieldNames()
			SynergyRecord = synRec
			OriginalSynergyRecord = synRec
			extendedConstructor()
		endmethod

		
        ;;Set up the arrays of field details
        private method configureFieldInfo	,void
			endparams
		proc
			<SYMPHONY_LOOPSTART>
            <FIELD_LOOP>
			<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			<SYMPHONY_LOOPINCREMENT>
            <IF NUMERIC>
			setFieldInfo("<FIELD_SQLNAME>", "<Field_sqlname>",  "<FIELD_CHANGEM>", "<FIELD_ARRIVEM>",
			&	"<FIELD_LEAVEM>", "<FIELD_ORIGINAL_NAME>", <FIELD_POSITION>, <FIELD_SIZE>,
			&	<FIELD_ELEMENT0>, 0, 0, 0,
			&	"<FIELD_TYPE_NAME>", <IF REQUIRED>true</IF><IF OPTIONAL>false</IF>, <FIELD_MINVALUE>, <FIELD_MAXVALUE>)
            <ELSE>
			setFieldInfo("<FIELD_SQLNAME>", "<Field_sqlname>",  "<FIELD_CHANGEM>", "<FIELD_ARRIVEM>",
			&	"<FIELD_LEAVEM>", "<FIELD_ORIGINAL_NAME>", <FIELD_POSITION>, <FIELD_SIZE>,
			&	<FIELD_ELEMENT0>, 0, 0, 0,
			&	"<FIELD_TYPE_NAME>", <IF REQUIRED>true</IF><IF OPTIONAL>false</IF>, 0, 0)
			</IF NUMERIC>

            </IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
            </FIELD_LOOP>
		endmethod

        ;;Set up the arrays of field names and headings
        private method setFieldNames	,void
			endparams
		proc
			<FIELD_LOOP>
			<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			mFieldNames.Add("<Field_sqlname>")
			mFieldHeadings.Add("<FIELD_HEADING>")
			</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
            </FIELD_LOOP>
		endmethod

        ;;Expose fields as properties for data binding
        <SYMPHONY_LOOPSTART>
        <FIELD_LOOP>
		<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
        ;;<Field_name>
		{DataMember}
		<IF DATE_YYYYMMDD>
		public property <Field_sqlname>, <FIELD_CSTYPE>?
		<ELSE>
		public property <Field_sqlname>, <FIELD_CSTYPE>
		</IF DATE_YYYYMMDD>
			method get
			proc

			    <IF ALPHA>
			    mreturn (<FIELD_CSTYPE>)mAlphaConveter.Convert(<Structure_name>_main.<Field_name>, ^null, ^null, ^null)
			    </IF ALPHA>
			    <IF DATE_YYYYMMDD>
			    <IF DATETODAY>
			    mreturn (<FIELD_CSTYPE>?)mDateConveter.Convert(<Structure_name>_main.<Field_name>, ^null, "", ^null)
			    <ELSE>
			    mreturn (<FIELD_CSTYPE>?)mDateConveter.Convert(<Structure_name>_main.<Field_name>, ^null, "NODEFAULTODAY", ^null)
			    </IF DATETODAY>
			    </IF DATE_YYYYMMDD>
			    <IF DECIMAL>
			    <IF PRECISION>
			    mreturn (<FIELD_CSTYPE>)mImpliedDecimalConveter.Convert(<Structure_name>_main.<Field_name>, ^null, ^null, ^null)
			    <ELSE>
			    mreturn Convert.ToInt32(mDecimalConveter.Convert(<Structure_name>_main.<Field_name>, ^null, ^null, ^null))
			    </IF PRECISION>
			    </IF DECIMAL>
			    <IF INTEGER>
			    mreturn (<FIELD_CSTYPE>)mIntegerConveter.Convert(<Structure_name>_main.<Field_name>, ^null, ^null, ^null)
			    </IF INTEGER>
			endmethod
			method set
			proc
			    <IF ALPHA>
			    <Structure_name>_main.<Field_name> = (<FIELD_TYPE>)mAlphaConveter.ConvertBack(value, ^null, ^null, ^null)
			    </IF ALPHA>
			    <IF DATE_YYYYMMDD>
			    <Structure_name>_main.<Field_name> = (<FIELD_TYPE>)mDateConveter.ConvertBack(value, ^null, ^null, ^null)
			    </IF DATE_YYYYMMDD>
			    <IF DECIMAL>
			    <IF PRECISION>
			    <Structure_name>_main.<Field_name> = (ID)mImpliedDecimalConveter.ConvertBack(value, ^null, ^null, ^null)
			    <ELSE>
			    <Structure_name>_main.<Field_name> = (<FIELD_TYPE>)mDecimalConveter.ConvertBack(value, ^null, ^null, ^null)
			    </IF PRECISION>
			    </IF DECIMAL>
			    <IF INTEGER>
			    <Structure_name>_main.<Field_name> = (<FIELD_TYPE>)mIntegerConveter.ConvertBack(value, ^null, ^null, ^null)
			    </IF INTEGER>


				if (<Structure_name>_main.<Field_name> != <Structure_name>_store.<Field_name>)
				begin
					;//ValidateEnteredData(<FIELD#LOGICAL>)
					<SYMPHONY_LOOPINCREMENT>;//increment the loop
					ValidateEnteredData(<SYMPHONY_LOOPVALUE>)
					RaisePropertyChanged("<Field_sqlname>")
					<IF ALPHA>
					<IF ARRAY>
					RaisePropertyChanged("<Field_basename>")
					</IF ARRAY>
                    </IF ALPHA>
                    <Structure_name>_store.<Field_name> = <Structure_name>_main.<Field_name>
				end
			endmethod
		endproperty
		</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
        </FIELD_LOOP>
			
		private mSynchanged	,boolean
		
        ;;; <summary>
        ;;; Expose the complete synergy record
        ;;; </summary>
		public override property SynergyRecord, String
            method get
            proc
                mreturn <Structure_name>_main
            endmethod
            method set
            proc
				mSynchanged = false
				
				if (!mDoneSynergyRecordValue)
					OriginalSynergyRecord = value

				mDoneSynergyRecordValue = true

				setUsed()
                <Structure_name>_main = value

                ;;Signal that all fields have changed
                <SYMPHONY_LOOPSTART>
                <FIELD_LOOP>
				<IF LANGUAGE>
				<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
                if (<Structure_name>_main.<Field_name> != <Structure_name>_store.<Field_name>)
                begin
					mSynchanged = true
                    SetFieldValid("<Field_sqlname>")
					<SYMPHONY_LOOPINCREMENT>	;//increment the loop
					<Structure_name>_store.<Field_name> = <Structure_name>_main.<Field_name>
					if (mValidateSynergyData) ValidateEnteredData(<SYMPHONY_LOOPVALUE>)
                    RaisePropertyChanged("<Field_sqlname>")
					<IF ALPHA>
				    <IF ARRAY>
					RaisePropertyChanged("<Field_basename>")
					</IF ARRAY>
                    </IF ALPHA>
                end
				</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
                </IF LANGUAGE>
                </FIELD_LOOP>
				if (mSynchanged)
					RaiseSynergyRecordChanged()
				<Structure_name>_store = <Structure_name>_main
            endmethod
        endproperty

        ;;; <summary>
        ;;; Allow the host to initialise all fields.
        ;;; </summary>
        public override method InitData ,void
        proc
            init <Structure_name>_main
            <FIELD_LOOP>
			<IF LANGUAGE>
			<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			<IF DEFAULT>
			<IF ALPHA>
			<Structure_name>_main.<Field_name> = "<FIELD_DEFAULT>"
			<ELSE>
            <Structure_name>_main.<Field_name> = <FIELD_DEFAULT>
			</IF ALPHA>
            </IF DEFAULT>
            if (<Structure_name>_main.<Field_name> != <Structure_name>_store.<Field_name>)
				RaisePropertyChanged("<Field_sqlname>")
			</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
            </IF LANGUAGE>
            </FIELD_LOOP>
			<Structure_name>_store = <Structure_name>_main
			parent.InitData()
        endmethod

        ;;; <summary>
        ;;; Allow the host to validate all fields. Each field will fire the validation method.
        ;;; </summary>
        public override method InitialValidateData, void
            endparams
        proc
			<SYMPHONY_LOOPSTART>
            <FIELD_LOOP>
			<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			<SYMPHONY_LOOPINCREMENT>	;//increment the loop
            ValidateEnteredData(<SYMPHONY_LOOPVALUE>)
            RaisePropertyChanged("<Field_sqlname>")
			</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
            </FIELD_LOOP>

        endmethod

        ;;; <summary>
        ;;; Indicate from the UI which field now has focus. This then signals the
        ;;; CurrentFieldInfo change event so the UI can get the current field details
        ;;; </summary>
        ;;; <param name="fieldName">Name of field with focus</param>
        public override method SetFieldFocusFlag    ,void
            in req fieldName                        ,String
            endparams
        proc
            using fieldName select
			<SYMPHONY_LOOPSTART>
            <FIELD_LOOP>
			<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			<SYMPHONY_LOOPINCREMENT>
            ("<FIELD_ORIGINAL_NAME>"), mCurrentField = <SYMPHONY_LOOPVALUE>
			</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
            </FIELD_LOOP>
            (),
                mCurrentField = 0
            endusing
            RaisePropertyChanged("CurrentFieldInfo")
        endmethod

        ;;; <summary>
        ;;; Expose information about the current field
        ;;; </summary>
        ;;; <returns>Current field information</returns>
        public property CurrentFieldInfo    ,String
            method get
            proc
                using mCurrentField select
				<SYMPHONY_LOOPSTART>
                <FIELD_LOOP>
				<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
				<SYMPHONY_LOOPINCREMENT>
                (<SYMPHONY_LOOPVALUE>),    mreturn "<FIELD_INFOLINE>"
				</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
                </FIELD_LOOP>
				(), mreturn ""  ;;if incorrect field value or not configured, ensure we clear the return value
                endusing
            endmethod
        endproperty

        ;;Expose properties to indicate whether fields are enabled
        <SYMPHONY_LOOPSTART>
        <FIELD_LOOP>
		<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
		<SYMPHONY_LOOPINCREMENT>

	{DataMember}
        public property <Field_sqlname>IsEnabled, Boolean
            method get
            proc
                mreturn GetFieldEnabledState(<SYMPHONY_LOOPVALUE>)
            endmethod
            method set
            proc
                SetFieldEnabledState(<SYMPHONY_LOOPVALUE>, value)
                RaiseNonRPSPropertyChanged("<Field_sqlname>IsEnabled")
            endmethod
        endproperty
		</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
        </FIELD_LOOP>

        ;;Expose properties to indicate whether fields are focussed
        <FIELD_LOOP>
		<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
		private m<Field_sqlname>IsFocused	,Boolean
		{DataMember}
		public property <Field_sqlname>IsFocused, Boolean
			method get
			proc
				mreturn m<Field_sqlname>IsFocused
			endmethod
			method set
			proc
				clearFocus()
				m<Field_sqlname>IsFocused = value
				RaiseNonRPSPropertyChanged("<Field_sqlname>IsFocused")
			endmethod
		endproperty
		</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
        </FIELD_LOOP>

		;;Expose properties to indicate whether fields are read only
		<SYMPHONY_LOOPSTART>
		<FIELD_LOOP>
		<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
		<SYMPHONY_LOOPINCREMENT>
		{DataMember}
		public property <Field_sqlname>IsReadOnly, Boolean
			method get
			proc
				mreturn GetFieldReadOnlyState(<SYMPHONY_LOOPVALUE>)
			endmethod
			method set
			proc
				SetFieldReadOnlyState(<SYMPHONY_LOOPVALUE>, value)
				RaiseNonRPSPropertyChanged("<Field_sqlname>IsReadOnly")
			endmethod
		endproperty
		</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
		</FIELD_LOOP>

		private doingClearFocus	,Boolean	,false

		private method clearFocus, void
			endparams
		proc
			if (!doingClearFocus)
			begin
				doingClearFocus = true
				<FIELD_LOOP>
				<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
				if (<Field_sqlname>IsFocused) <Field_sqlname>IsFocused = false
				</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
                </FIELD_LOOP>
				doingClearFocus = false
			end
		endmethod


		public override method CompareObjects	,int
			in req obj1							,@Object
			in req obj2							,@Object
			in req colName						,String
			in req sortDir						,Symphony.Conductor.Framework.SynergySortOrder
			endparams

			.include '<structure_noalias>' repository <RPSDATAFILES>, record = 'data1', prefix = "<FIELD_PREFIX>", end
			.include '<structure_noalias>' repository <RPSDATAFILES>, record = 'data2', prefix = "<FIELD_PREFIX>", end

			record
				result		,int
			endrecord
		proc
			data1 = ((<Structure_name>_Data)obj1).SynergyRecord
			data2 = ((<Structure_name>_Data)obj2).SynergyRecord
			using colName select
			<FIELD_LOOP>
			<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			("<Field_sqlname>"),
			begin
				if (data1.<field_name> == data2.<field_name>) then
					result = 0
				else
				begin
					if (data1.<field_name> > data2.<field_name>) then
					begin
						if (sortDir == Symphony.Conductor.Framework.SynergySortOrder.Ascending) then
							result = -1
						else
							result = 1
					end
					else
					begin
						if (sortDir == Symphony.Conductor.Framework.SynergySortOrder.Descending) then
							result = -1
						else
							result = 1
					end
				end
			end
			</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
            </FIELD_LOOP>
			(),
				result = this.CustomCompareObjects(obj1, obj2, colName, sortDir)
			endusing

			mreturn result
		endmethod

	endclass
endnamespace

