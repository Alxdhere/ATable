;;;                                                                    ;
;;;  Pseudo2Grid.LSP                                                   ;
;;;                                                                    ;
;;;  Copyright 2012 by Alexander Shchetinin. All Rights Reserved.      ;
;;;                                                                    ;
;;;  You are hereby granted permission to use, copy and modify this    ;
;;;  software without charge, provided you do so exclusively for       ;
;;;  your own use or for use by others in your organization in the     ;
;;;  performance of their normal duties, and provided further that     ;
;;;  the above copyright notice appears in all copies and both that    ;
;;;  copyright notice and the limited warranty and restricted rights   ;
;;;  notice below appear in all supporting documentation.              ;
;;;                                                                    ;
;;;  Incorporation of any part of this software into other software,   ;
;;;  except when such incorporation is exclusively for your own use    ;
;;;  or for use by others in your organization in the performance of   ;
;;;  their normal duties, is prohibited without the prior written      ;
;;;  consent of author.                                                ;
;;;                                                                    ;
;;;  Copying, modification and distribution of this software or any    ;
;;;  part thereof in any form except as expressly provided herein is   ;
;;;  prohibited without the prior written consent of author.           ;
;;;                                                                    ;
;;;  AUTHOR PROVIDES THIS SOFTWARE "AS IS" AND WITH ALL FAULTS.        ;
;;;  AUTHOR SPECIFICALLY DISCLAIMS ANY IMPLIED WARRANTY OF             ;
;;;  MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE.  AUTHOR,         ;
;;;  DOES NOT WARRANT THAT THE OPERATION OF THE SOFTWARE               ;
;;;  WILL BE UNINTERRUPTED OR ERROR FREE.                              ;
;;;                                                                    ;
;;;--------------------------------------------------------------------;
;;;       Function:  Pseudo2Grid                                       ;
;;;                                                                    ;
;;;    Description:  This function is copy pseudo-table text from      ;
;;;                  drawing to active grid in ATable editor.          ;
;;;                                                                    ;
;;;                                                                    ;
;;;                  Required Application: ATable for AutoCAD 2012     ;
;;;                                                                    ;
;;;      Arguments:  None                                              ;
;;;                                                                    ;
;;; Returned Value:  None	                                       ;
;;;                                                                    ;
;;;          Usage:  Load Pseudo2Grid.lsp in AutoCAD by command Appload;
;;;                  Run ATable for AutoCAD. Display ATable editor     ;
;;;                  Enter option Add-ons in command line. Select menu ;
;;;                  Table and item Import from pseudo-table.          ;
;;;                                                                    ;
;;; Specially thanks to Peter Loskutov for convert "engine".           ;
;;;                                                                    ;
;;;--------------------------------------------------------------------;

(vl-load-com)

;You can localize this application. Only change text strings below.
(setq atableG2Glocal
  (list 
    (cons 20 "Alxd ATable закрыт или недоступен!")
    (cons 30 "Active sheet of Alxd ATable is closed or unavailable!")
    (cons 70 "\nSelect entites: ")
    (cons 120 "\nНичего не выбрано или выбраны объекты неподходящие типа!")
    (cons 121 "\nПодождите, пожалуйста...")
    (cons 122 "готово.")
  )
)

(defun getLocal ( slocal nlocal / )
  (cdr (assoc nlocal slocal))
)

;old version (defun c:atImportG2G( / tmp)
(defun c:atExchangeGrid2Grid( / )
  '("Импорт ручной таблицы..." "Импорт таблицы из чертежа созданной ручным способом или разбитую командной _explode" "alxd:atInterfaceGrid2Grid")
)

;old version (defun alxd:interfaceG2G( app / tmp oSheets oSheet oDict xx xx2 coords topright botleft)
(defun alxd:atInterfaceGrid2Grid( / app tmp oSheets oSheet oDict xx xx2 coords topright botleft)
  (setq 
    app (vlax-get-object "AlxdGrid.AlxdApplication")
    oSheets (vlax-get-property (vlax-get-property app 'AlxdEditor) 'AlxdSpreadSheets)
    tmp (vlax-get-property oSheets 'Active)
    oSheet (vlax-get-property oSheets 'Items tmp)
  )

  (setq coords (list) xx (ssget))
  (if (= xx nil)
    (princ (getlocal atableG2Glocal 120))
    (progn
      (mapcar 
        '(lambda (x)
           (if (< (car x) 0)
             (mapcar 
               '(lambda (d)
                  (if (= (listp d) T)
                    (setq coords (append coords (cdr d))) 
                  )
                )
               x
             )
           )
         );lambda
        (ssnamex xx)
      )'mapcar

      (setq topright (car coords) botleft (car coords))
      (mapcar 
        '(lambda (x)
           (if (and (>= (car x) (car topright)) (>= (cadr x) (cadr topright)))
             (setq topright x)
           )

           (if (and (<= (car x) (car botleft)) (<= (cadr x) (cadr botleft)))
             (setq botleft x)
           )
  
         );lambda
        coords
      )'mapcar

      (list2grid oSheet topright botleft)

    );progn
  );(if (= xx nil)

  (vlax-release-object oSheet)
  (vlax-release-object oSheets) 
  (vlax-release-object app)
  
  (princ)
)

(defun list2grid ( oSheet pt1 pt2 / textlist atActiveSheet atCols atRows atCells atCell wi wj li lj tmp)
  (princ (getlocal atableG2Glocal 121))

  ;is not my function
  ;great thanks to Peter Loskutov
  (setq textlist (pl:convert-to-table (list pt1 pt2)))

  (if (= textlist nil)
    (princ (getlocal atableG2Glocal 120))
    (progn
      (setq 
        atCols (vlax-get-property oSheet 'AlxdColumns)
        atRows (vlax-get-property oSheet 'AlxdRows)
        atCells (vlax-get-property oSheet 'AlxdCells)
        tmp (vlax-get-property atRows 'Count)
      )
      (vlax-invoke-method oSheet 'AddRows (if (< tmp (length textlist)) (- (length textlist) tmp) 0))      

      (setq wj 0)
      (foreach li textlist

        (setq wi 0)
        (foreach lj li
          (setq tmp (vlax-get-property atCols 'Count))
          (if (> (length li) (vlax-get-property atCols 'Count))
            (vlax-invoke-method oSheet 'AddColumns (if (< tmp (length li)) (- (length li) tmp) 0))
          )

          (setq atCell (vlax-get-property atCells 'Items wi wj))
          (vlax-put-property atCell 'Contain lj)
          (vlax-release-object atCell)

          (setq wi (1+ wi))
        );foreach lj

        (setq wj (1+ wj))
      );foreach li
 
      (vlax-invoke-method oSheet 'Recalculate)
      (vlax-invoke-method oSheet 'RedrawBlockDefinition)

      (vlax-release-object atCells)
      (vlax-release-object atRows)
      (vlax-release-object atCols)
    )
  )

  (princ (getlocal atableG2Glocal 122))  
)



;-----------------------------------
;
;COOL code below from Peter Loskutov
;
;-----------------------------------

(defun pl:convert-to-table (pnts)
  (if pnts
    (mapcar (function (lambda (a) (mapcar (function (lambda (b) (vl-string-trim " " b))) a)))
            (pl:get-tbl-data1 (pl:get-tbl-ents1 pnts)) ;_ получаем содержимое выборки
    ) ;_ чистим строки от начальных и концевых пробелов
  )
)


(defun pl:get-tbl-ents1 (_box) ;_ функция выбора примитивов составляющих таблицу
  (setq _box (list (list (min (caar _box) (caadr _box)) (max (cadar _box) (cadadr _box)))
                   (list (max (caar _box) (caadr _box)) (min (cadar _box) (cadadr _box)))
             )
  )
  (list _box
        (ssget "_C" (car _box) (cadr _box) '((0 . "LINE")))
        (ssget "_C" (car _box) (cadr _box) '((0 . "LWPOLYLINE")))
        (ssget "_C" (car _box) (cadr _box) '((0 . "TEXT")))
  )
)

(defun pl:get-tbl-data1 (_sel / _sel _texts _lhrzn _lines _lvert _lwpl _modcol _modrow _mtx)
  (if (setq _texts (last _sel))
    (progn
      (setq _lines (cadr _sel)
            _lwpl  (caddr _sel)
            _sel   (car _sel)
      ) ;_ end of setq
      (if _lines
        (setq _lines (mapcar (function pl:extr-pnt-from-line) (pl:entlst-from-ss _lines)))
      ) ;_ end of if
      (if _lwpl
        (setq _lwpl (apply (function append)
                           (mapcar (function pl:lwpl-to-segments) (pl:entlst-from-ss _lwpl))
                    )
        ) ;_ end of setq
      ) ;_ end of if
      (if
        (and
          (setq _lines (append _lines _lwpl))
          (setq _lines (vl-remove-if-not
                         (function (lambda (x) (pl:is-point-in-bbox (pl:get-cen-pnts-2d x) _sel)))
                         _lines
                       ) ;_ end of vl-remove-if-not
          ) ;_ end of setq
          (setq _lines (mapcar (function (lambda (x) (pl:near-orto x 3))) _lines))
          (> (length (setq
                       _lvert (mapcar
                                (function cdr)
                                (vl-remove-if (function (lambda (x) (or (not x) (= (car x) 0)))) _lines)
                              ) ;_ end of mapcar
                     ) ;_ end of setq
             ) ;_ end of length
             1
          ) ;_ end of >
          (> (length (setq
                       _lhrzn (mapcar
                                (function cdr)
                                (vl-remove-if (function (lambda (x) (or (not x) (= (car x) 1)))) _lines)
                              ) ;_ end of mapcar
                     ) ;_ end of setq
             ) ;_ end of length
             1
          ) ;_ end of >
        ) ;_ end of and
         (progn (setq _modcol (pl:get-len-perc _lvert 1.0)
                      _modrow (* 0.5
                                 (apply (function min)
                                        (mapcar (function vla-get-height)
                                                (setq _texts (mapcar (function vlax-ename->vla-object)
                                                                     (pl:entlst-from-ss _texts)
                                                             )
                                                ) ;_ end of setq
                                        ) ;_ end of mapcar
                                 ) ;_ end of apply
                              ) ;_ end of *
                      _lvert  (pl:clr-near-doub (pl:sort (function <) _lvert) _modcol)
                      _lhrzn  (pl:sort (function >) (pl:clr-near-doub (pl:sort (function <) _lhrzn) _modrow))
                      _texts  (mapcar (function list)
                                      (mapcar (function pl:get-cen-pnts) (mapcar (function pl:get-bbox) _texts))
                                      _texts
                              )
                      _mtx    (pl:mk-arr-from-lns _lhrzn _lvert)
                      _mtx    (mapcar (function (lambda (a b) (mapcar (function list) a b)))
                                      _mtx
                                      (mapcar (function cdr) (cdr _mtx))
                              ) ;_ end of mapcar
                      _mtx    (mapcar
                                (function
                                  (lambda (a)
                                    (mapcar
                                      (function (lambda (b)
                                                  (pl:txts-conc1
                                                    (vl-remove-if-not
                                                      (function (lambda (c) (pl:is-point-in-bbox (car c) b)))
                                                      _texts
                                                    ) ;_ end of vl-remove-if-not
                                                  ) ;_ end of cadar
                                                ) ;_ end of lambda
                                      ) ;_ end of function
                                      a
                                    ) ;_ end of mapcar
                                  ) ;_ end of lambda
                                ) ;_ end of function
                                _mtx
                              ) ;_ end of mapcar
                ) ;_ end of setq
                (mapcar (function (lambda (b)
                                    (mapcar (function (lambda (c)
                                                        (cond (c)
                                                              (t "")
                                                        ) ;_ end of cond
                                                      ) ;_ end of lambda
                                            ) ;_ end of function
                                            b
                                    ) ;_ end of mapcar
                                  ) ;_ end of lambda
                        ) ;_ end of function
;;;                   (vl-remove-if-not (function (lambda (a) (apply (function or) a))) _mtx)
                        _mtx ;_ Если не нужны пустые строки, то - удалить эту строку и активировать предыдущую.
                ) ;_ end of mapcar
         ) ;_ end of progn
      ) ;_ end of if
    ) ;_ end of progn
  ) ;_ end of if
) ;_ end of defun

(defun pl:txts-conc1 (i-lst) ;_ функция слияния строк попавших в одну ячейку
  (cond ((not i-lst) nil)
        ((= (length i-lst) 1) (vla-get-textstring (cadar i-lst)))
        (t
         (apply (function strcat)
                (mapcar (function (lambda (c / tmp)
                                    (setq tmp (vl-string-trim " " (vla-get-textstring (cadr c))))
                                    (if (= (last (vl-string->list tmp)) 45)
                                      (vl-string-right-trim "-" tmp)
                                      (strcat tmp " ")
                                    ) ;_ end of if
                                  ) ;_ end of lambda
                        ) ;_ end of function
                        (pl:sort (function (lambda (a b / tmp)
                                             (setq tmp (angle (car a) (car b)))
                                             (or (< 0 tmp 0.52359878) (< 4.1887902 tmp 6.2831853))
                                           ) ;_ end of lambda
                                 ) ;_ end of function
                                 i-lst
                        ) ;_ end of pl:sort
                ) ;_ end of mapcar
         ) ;_ end of apply
        )
  ) ;_ end of cond
) ;_ end of defun

(defun pl:mk-arr-from-lns (col row) ;_ функция генерации координат массива ячеек
  (mapcar (function (lambda (a) (mapcar (function (lambda (b) (list b a))) row))) col)
) ;_ end of defun

(defun pl:clr-near-doub (ilst mod / el tmp)
  (if ilst
    (progn (setq el  (car ilst)
                 tmp (pl:clr-near-doub (cdr ilst) mod)
           ) ;_ end of setq
           (if (and tmp (> el (- (car tmp) mod)))
             tmp
             (cons el tmp)
           ) ;_ end of if
    ) ;_ end of progn
  ) ;_ end of if
) ;_ end of defun

(defun pl:get-len-perc (lst perc) ;_ функция определения вертикальности линии с допуском на кривизну рук
  (* (abs (- (apply (function max) lst) (apply (function min) lst))) 0.01 perc)
)

(defun pl:extr-pnt-from-line (_line / _p1 _p2) ;_ функция извлечения координат из линий
  (setq _line (entget _line)
        _p1   (cdr (assoc 10 _line))
        _p2   (cdr (assoc 11 _line))
  ) ;_ end of setq
  (list (list (car _p1) (cadr _p1)) (list (car _p2) (cadr _p2)))
) ;_ end of defun

(defun pl:extr-pnt-from-lwline (_dxf) ;_ функция извлечения координат из облегчённых полилиний
  (mapcar (function cdr) (vl-remove-if-not (function (lambda (x) (= 10 (car x)))) _dxf))
) ;_ end of defun

(defun pl:lwpl-to-segments (_lwline / _vert) ;_ функция генерации сегментов из облегчённых полилиний
  (setq _lwline (entget _lwline)
        _vert   (pl:extr-pnt-from-lwline _lwline)
  ) ;_ end of setq
  (mapcar (function list)
          (if (zerop (logand 1 (cdr (assoc 70 _lwline))))
            (cdr _vert)
            (cons (last _vert) _vert)
          ) ;_ end of if
          _vert
  ) ;_ end of mapcar
) ;_ end of defun

(defun pl:near-orto (_lstpnt _delta / _ang _dir) ;_ функция определения ортогональных линий с допуском на кривизну рук
  (setq _ang   (rem (apply (function angle) _lstpnt) pi)
        _delta (rem (/ (* pi _delta) 180) (* pi 2))
        _dir   (cond ((>= (+ (/ pi 2) _delta) _ang (- (/ pi 2) _delta)) 1)
                     ((or (>= _delta _ang 0) (>= pi _ang (- pi _delta))) 0)
                     (t nil)
               ) ;_ end of cond
  ) ;_ end of setq
  (if _dir
    (cons _dir
          (/ (apply (function +)
                    (mapcar (if (= _dir 0)
                              (function cadr)
                              (function car)
                            ) ;_ end of if
                            _lstpnt
                    ) ;_ end of mapcar
             ) ;_ end of apply
             2
          ) ;_ end of /
    ) ;_ end of cons
  ) ;_ end of if
) ;_ end of defun

(defun pl:sort (func lst) ;_ функция упрощённой сортировки
  (mapcar (function (lambda (x) (nth x lst))) (vl-sort-i lst func))
)

(defun pl:entlst-from-ss (ss) ;_ функция упрощённого извлечения примитивов из набора
  (vl-remove-if (function listp) (mapcar (function cadr) (ssnamex ss)))
)

(defun pl:get-bbox (obj / minpoint maxpoint) ;_ функция получения габаритных координат
  (vla-getboundingbox obj 'minpoint 'maxpoint)
  (mapcar (function vlax-safearray->list) (list minpoint maxpoint))
) ;_ end of defun

(defun pl:is-point-in-bbox (point bbox) ;_ функция определения попадания точки в габарит
  (apply (function and)
         (mapcar (function (lambda (x y) (<= (apply (function min) x) y (apply (function max) x))))
                 (apply (function mapcar) (cons (function list) bbox))
                 point
         ) ;_ end of mapcar
  ) ;_ end of apply
) ;_ end of defun

(defun pl:get-cen-pnts (pntlst / len) ;_ функция получения средней точки
  (setq len (length pntlst))
  (list (/ (apply (function +) (mapcar (function car) pntlst)) len)
        (/ (apply (function +) (mapcar (function cadr) pntlst)) len)
        (/ (apply (function +) (mapcar (function caddr) pntlst)) len)
  ) ;_ end of list
) ;_ end of defun

(defun pl:get-cen-pnts-2d (pntlst / len) ;_ функция получения двумерной средней точки
  (setq len (length pntlst))
  (list (/ (apply (function +) (mapcar (function car) pntlst)) len)
        (/ (apply (function +) (mapcar (function cadr) pntlst)) len)
  )
) ;_ end of defun

(princ "\nPseudo2Grid v1.2 (addon for ATable) - input pseudo-table from drawing to tables")
(princ)
