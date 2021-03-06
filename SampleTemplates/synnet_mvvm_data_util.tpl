<CODEGEN_FILENAME>DataUtils.dbl</CODEGEN_FILENAME>
<REQUIRES_USERTOKEN>MVVM_DATA_NAMESPACE</REQUIRES_USERTOKEN>
;//****************************************************************************
;//
;// Title:       mvvm_data_util.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Generates a class containing various data conversion utilities
;//
;// Date:        17th February 2011
;//
;// Author:      Steve Ives, Synergex Professional Services Group
;//              http://www.synergex.com
;//
;//****************************************************************************
;//
;// Copyright (c) 2012, Synergex International, Inc.
;// All rights reserved.
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
;;*****************************************************************************
;;
;; File:        DataUtils.dbl
;;
;; Description: Data conversion utilities
;;
;; Type:        Class
;;
;; Author:      <AUTHOR>, <COMPANY>
;;
;;*****************************************************************************
;;
;; WARNING:     This code was generated by CodeGen. Any changes that you make
;;              to this file will be lost if the code is regenerated.
;;
;;*****************************************************************************

import System

namespace <MVVM_DATA_NAMESPACE>

    public static class DataUtils

        public static method DateFromDecimal, DateTime
            required in aDecimalDate, d
            endparams
            record
                group date6
                    year    ,d2
                    month   ,d2
                    day     ,d2
                endgroup
                group date8
                    year    ,d4
                    month   ,d2
                    day     ,d2
                endgroup
                outDate, DateTime
            endrecord
        proc

            using ^size(aDecimalDate) select
            (6),
            begin
                date6 = aDecimalDate
                outdate = new DateTime(integer(date6.year),integer(date6.month),integer(date6.day))
            end
            (8),
            begin
                date8 = aDecimalDate
                outdate = new DateTime(integer(date8.year),integer(date8.month),integer(date8.day))
            end
            (),
                throw new ApplicationException("Unsupported date format in DataUtils.DateFromDecimal!")
            endusing

            mreturn outDate

        endmethod

        public static method TimeFromDecimal, DateTime
            required in aDecimalTime, d
            endparams
            record
                group time4
                    hour    ,d2
                    minute  ,d2
                endgroup
                group time6
                    hour    ,d2
                    minute  ,d2
                    second  ,d2
                endgroup
                outTime, DateTime
            endrecord
        proc

            using ^size(aDecimalTime) select
            (4),
            begin
                time4 = aDecimalTime
                outTime = new DateTime(0,0,0,integer(time4.hour),integer(time4.minute),0)
            end
            (6),
            begin
                time6 = aDecimalTime
                outTime = new DateTime(0,0,0,integer(time6.hour),integer(time6.minute),integer(time6.second))
            end
            (),
                throw new ApplicationException("Unsupported time format in DataUtils.TimeFromDecimal!")
            endusing

            mreturn outtime

        endmethod

    endclass

endnamespace

