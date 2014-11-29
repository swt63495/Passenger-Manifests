
<?php


	/*
	For a given row in manifest table
		1) get row id (m_id)
		2) get 1st & last names of:
			passenger
			relative back home
			person at destination
		   and place them in an $array
		3) foreach($array as $np)
				Match name-pair to person in 'person_of_record' table. For the moment,
			 	we will assume that the names are in there. Collect person's id  ('id_person').

			 	retrieve person id
		4)

		*/

	function connect_to($schema){

		/* connect to database */
		$new_dbc = mysqli_connect("localhost", "root", "", $schema);

		/* check connection */
		if (mysqli_connect_errno()) {
			printf("<p class = 'ghost'>Connect failed: %s</p>\n", mysqli_connect_error());
			exit();
		} else {
			printf("<p class = 'ghost'>Successful connection</p>\n");
		}

		return $new_dbc;
	}

	function lookup_id($dbc, $tbl, $id, $things){
		/*
			Takes an array of tuples of field => value.
			Empty fields are set as NULL.

		*/

		$criteria = "";

		foreach ($things as $field => $value) {

			if(is_null($value)){
				$criteria .= "$field IS NULL AND ";
			}
			else {
				$criteria .= "$field = '$value' AND ";
			}

		} // end for loop

		// trim trailing 'AND ' from list of fields and values

		$pattern = '/ AND $/';
		$replace = '';

		$criteria = preg_replace($pattern, $replace, $criteria);

		// build SELECT query...

		$query = "SELECT $id FROM $tbl WHERE $criteria";
		echo "<p class = 'ghost'>The query is [$query]</p>\n";

		// =================== common code ===================

		/* ...and run it */
		$result = mysqli_query($dbc, $query);

		// /* check for query error Andy-style: */
		if($result === FALSE) {
			die(mysqli_error($dbc)); // TODO: better error handling
		}

		// /* Check for matching entry*/
		if(mysqli_num_rows($result) > 0){ 
			$row = mysqli_fetch_row($result); // should be only one row!!!
			$the_id = $row[0];
		} else { //	$row_cnt of 0 means no match was found -> return 0 (='not found')
			$the_id = 0;
		}

		// /* close result set */
		mysqli_free_result($result);

		return $the_id;

	}

	function create_record($dbc, $tbl, $things){
		/*

		This GENERIC function will insert a new record into $tbl and return its p_key value.
		Things is a user-passed array of 'field => value' tuples. Function is currently configured 
		to skip tupples with NULL $values. 

		*/

		$f = "";
		$v = "";

		foreach ($things as $field => $value) {
			// if(!($value == 'NULL')){
			if(!empty($value)){
				$f .= "$field, "; // notice lack of single-quotes! This should work!
				$v .= "'$value', ";
			}
		}


		// trim trailing ','' from list of fields and values

		$pattern = '/, $/';
		$replace = '';

		$v = preg_replace($pattern, $replace, $v);
		$f = preg_replace($pattern, $replace, $f);

		// build INSERTion query...
		$query = "INSERT into $tbl ( $f ) VALUES ($v)";
		echo "<p>query is [$query]</p>\n"; // works thru here!

		// // ...run it...
		if( !mysqli_query($dbc, $query) ){ // SQL syntax error! Double check Php SQL manual
			die("Error description: " . mysqli_error($dbc));
		} // end if

		//exit("<p class = 'ghost'>Stop here for now</p>\n");

		$new_id = mysqli_insert_id($dbc);

		return $new_id;

	} // end create new record

	function create_new_vessel_record($dbc, $v){
		//maybe add failure return value

		// build INSERTion query...
		$query = "INSERT into vessel(vessel_name) VALUES ('$v')";
		echo "<p>query is [$query]</p>\n";

		// ...run it...
		// if( !mysqli_query($dbc, $query) ){
		// 	die("Error description: " . mysqli_error($dbc));
		// } // end if

		// $new_id = mysqli_insert_id($dbc);

		// echo "<p class = 'ghost'>New vessel id is " . $new_id . "</p>\n";

		// return $new_id;

	} // end 'insert $new_vessel_name'

?>
