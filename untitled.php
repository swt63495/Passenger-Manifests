<?php

// Test

	// ====================== vessel queries INSERT & SELECT (see word document) ======================



	// ====================== common code ======================

	// Cases 1A-1C: check value of $vessel_id; fail if no value!

	if (!isset($_POST['vessel_id'])) {
		die("no vessel selected!");
	} else {
		$vessel_id = $_POST['vessel_id'];
	}

	// If we haven't already, connect to the database & get dbc


	// ====================== INSERT new vessel query ======================
	// need to double check 'new' vessel isn't already on file!
	// Maybe run select query 1st and fork on whether new vessel passed by user!

	// intval($x) -- Returns the integer value of var $x

	if($vessel_id != "9999" ) {

	/*	We have a valid (on file) vessel ID, so we run a select query using the ID to pull up additional info
		Cases 4A-4C
	*/


		/* Start building the query... */
		$query = "SELECT * FROM vessel WHERE id_vessel = '$vessel_id'";
		echo "<p>query is [$query]</p>\n";

		/* ...and run it */
		$result = mysqli_query($dbc, $query);

		// check for error
		if(!$result === FALSE){ // it's good!

			// Output results table
			echo "<table border='1'>
				<tr>
					<th>Vessel</th><th>ID</th>
				</tr>";

			while ($row = mysqli_fetch_array($result)) {
				echo "<tr>";
					echo "<td>" . $row['vessel'] . "</td>";
					echo "<td>" . $row['id_vessel'] . "</td>";
				echo "</tr>";
			} // end while

			echo "</table>";

		} else { // uh, it's baaaadd
			echo "<p>Vessel query retrieved no rows</p>\n";
		} // end 'if $result'

	/* close result set */
	mysqli_free_result($result); // only needed for select query!

	} // end of '!$vessel_id == 9999 ''

	// ==================================================================


/* We have an insertion request, so check if all of the following are true:

	 1) ID == 9999
	 2) Vessel name is not on file
	 3) Vessel name is not Empty

	 If all of these conditions have been met, then we are good to go insert!
 */

	if($vessel_id == "9999" ) { // change to zero!!

		echo "<p>I. '$vessel_id' == '9999'</p>\n";

		// Case 2A
		if(!$new_vessel_name) { // maybe have while loop here
			die( "No name of new vessel provided");
		}
		// check if new vessel is already on file

		echo "<p>II. Vessel name to check against list is '$new_vessel_name'</p>\n";

		// Build query...
		$query = "SELECT 'id_vessel', 'vessel_name' from 'vessel' WHERE 'vessel_name' = '$new_vessel_name'";

		echo "<p>III. Query is [$query]</p>\n";

		//...and run it...

		// Check for query FAILURE
		$result = mysqli_query($dbc, $query);
		if($result === FALSE) {
			echo"<p>Query failed: " . mysqli_error($dbc) . "</p>\n";
			mysqli_free_result($result); // only needed for select query!
			die();
		}

		/* check for empty results set */
		// if (empty($results)) doesn't work like you think...

		if (!mysqli_num_rows($result)) {
			echo "<p>No match found, Dude! $new_vessel_name is not on file.</p>\n";
			mysqli_free_result($result); // only needed for select query!
			die();
		}
		
		/*	diagnostic	*/
		$Vrow = mysqli_fetch_array($result);
		echo "<p>IV) vessel name is: " . $Vrow['vessel_name'] . "<br />";
		echo "vessel id is: " . $Vrow['id_vessel'] . "</p>\n";


		// Check for matching name--Case 2B
		if($result){
			echo "<p>$new_vessel_name already exists in list of vessels!</p>\n";
			// echo "<p>$result[0][2]</p>\n"
			exit(); // for now, just proceed die
		} else { //Case 2C: it's a go for insertion!

			// build INSERTion query...
			$new_id = id_new_record($dbc, 'vessel', 'vessel_name', $new_vessel_name);

			echo "<p>New vessel id is " . $new_id . "</p>\n";
		}// end 'insert $new_vessel_name'
			

	}


?>