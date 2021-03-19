;;;****************************************************************************************
;;;FUNCTIONS AND DEFINITIONS FOR WATER JUG PROBLEM
;;;to be used concurrently with "search statistics" and a search file
;;;****************************************************************************************

(defclass jug-state (state)
      ((five :initarg :five :initform nil :accessor five :documentation "amount in 5-gallon jug")
            (two :initarg :two :initform nil :accessor two :documentation "amount in 2-gallon jug")))

(defparameter *water-jug* 
    (make-instance 'problem 
		       :start-state (make-instance 'jug-state :five 5 :two 2)
		           :goal-test 'one-in-two
			       :operators '(dump-5 dump-2 fill-5-from-2 fill-2-from-5 empty-2-into-5 empty-5-into-2)
			           :name "water jug"))

;;;****************************************************************************************
;;;SEARCH SUPPORT FUNCTIONS
;;;****************************************************************************************

(defmethod equal-states ((self jug-state) (other jug-state))
    (and (equal (five self) (five other))
	        (equal (two self) (two other))))

(defmethod copy ((self jug-state))
    (make-instance 'jug-state :five (five self) :two (two self)))

(defmethod one-in-two ((self jug-state))
      (= 1 (two self)))

(defmethod estimated-distance-from-goal ((self jug-state))
    (declare (ignore self))
      1)

;;;****************************************************************************************
;;;OPERATORS AND THEIR SUPPORTING DEFINITIONS
;;;****************************************************************************************

(defmethod fill-5 ((self jug-state)) 
    (when (< (five self) 5)
          (let ((copy (copy self)))
	          (setf (five copy) 5)
		        copy)))

(defmethod fill-2 ((self jug-state)) 
    (when (< (two self) 2) 
          (let ((copy (copy self)))
	          (setf (two copy) 2)
		        copy)))

(defmethod dump-5 ((self jug-state))
    (when (> (five self) 0)
          (let ((copy (copy self)))
	          (setf (five copy) 0)
		        copy)))

(defmethod dump-2 ((self jug-state))
    (when (> (two self) 0)
          (let ((copy (copy self)))
	          (setf (two copy) 0)
		        copy)))

(defmethod fill-5-from-2 ((self jug-state))
    (let ((old-2 (two self))
	          (old-5 (five self))
		          (copy (copy self)))
          (when (and (> old-2 0)
		                    (< old-5 5)
				                   (> (+ old-5 old-2) 5))
	          (setf (two copy) (- old-2 (- 5 old-5)))
		        (setf (five copy) 5) 
			      copy)))

(defmethod fill-2-from-5 ((self jug-state))
      (let ((old-2 (two self))
	              (old-5 (five self))
		                (copy (copy self)))
	      (when (and (> old-5 0)
			                  (< old-2 5))
		        (setf (five copy) (- old-5 (- 2 old-2)))
			        (setf (two copy) 2)
					copy)))

(defmethod empty-5-into-2 ((self jug-state))
    (let ((old-2 (two self))
	          (old-5 (five self))
		          (copy (copy self)))
          (when (and (> old-5 0)
		                    (<= (+ old-5 old-2) 2))
	          (setf (two copy) (+ old-2 old-5))
		        (setf (five copy) 0)
			      copy)))

(defmethod empty-2-into-5 ((self jug-state))
    (let ((old-2 (two self))
	          (old-5 (five self))
		          (copy (copy self)))
          (when (and (> old-2 0)
		                    (<= (+ old-2 old-5) 5))
	          (setf (five copy) (+ old-2 old-5))
		        (setf (two copy) 0)
			      copy)))

;;;****************************************************************************************
;;;FOR DEMONSTRATION ONLY

(dump-5 (start-state *water-jug*))
(describe (dump-5 (start-state *water-jug*)))

(empty-2-into-5 (dump-2  (start-state *water-jug*)))
(describe (empty-2-into-5 (dump-2 (start-state *water-jug*))))

