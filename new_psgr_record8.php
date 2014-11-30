<html>

<script type="text/javascript">

	// uh, these are javascript functions!
	function hide(){
		var x = document.getElementsByClassName("ghost");
		var i;
		for (i = 0; i < x.length; i++) {
			//x[i].setAttribute('type', 'hidden');
			x[i].style.display = "none";
		}
	}

	function show(){
		var x = document.getElementsByClassName("ghost");
		var i;
		for (i = 0; i < x.length; i++) {
			// x[i].removeAttribute('type', 'hidden');
			x[i].style.display = "inherit";
		}
	}

</script>

<style type="text/css">

	.ghost, .red {
		color: red;
	}

	.bold{
		color: teal;
		font-size: 105%;
		font-weight: bold;
	}

</style>

	<button type="button" onclick="hide()">Hide <span class="red">Diagnostic</span> Info</button>
	<button type="button" onclick="show()">Show <span class="red">Diagnostic</span> Info</button>


	<?php

	// ==================

	// using NULLs instead of 'NULL's 
	// 1) default value of fields in NULL
	// 2) This will be useful somehow when we collect manifest info fields -->
	// create records with non-null fields, rest of fields default to null!

	include_once('php_functions3.php');


	$user_form = 'psgr_data_entry_form8.html';

	$dbc = connect_to("gene25");

	$manifest_terms = array();

	// ====================== Persons ======================

	// $category = array('passenger' => 'pa_id', 'relative_at_previous_residence' => 'rbh_id', 'person_at_destination', 'dp_id');

	$category = array(
		'passenger' => 'id_passenger', 
		'person_at_destination' => 'id_dest_person', 
		'relative_at_previous_residence' => 'id_relative_back_home'
	);

	var_dump($category);

	foreach ($category as $persona => $sql_field){
		// var_dump($_POST['person'][$type]['lname']);

		$searchterms = array(
		 'lname' => !empty($_POST['person'][$persona]['lname']) ? $_POST['person'][$persona]['lname'] : NULL,
		 'fname' => !empty($_POST['person'][$persona]['fname']) ? $_POST['person'][$persona]['fname'] : NULL,
		 );

		var_dump($searchterms);

		echo"<p class = 'ghost'>Person's name is '$searchterms[fname] $searchterms[lname]'.<br />
		Their persona is <b>$persona</b>.</p>\n";


		echo "<p class = 'ghost'>Search terms are<br />
			'$searchterms[fname]', <br />
			'$searchterms[lname]'.
			</p>\n";

		if($p_id = lookup_id($dbc, 'record_of_person', 'id_person', $searchterms)){

			echo"<p>Id of <span class='bold'>$persona</span>--'{$searchterms['fname']} {$searchterms['lname']}'--is <b>$p_id</b>.</p>\n";

		} else {

			echo"<p>The <span class='bold'>$persona</span>--'{$searchterms['fname']} {$searchterms['lname']}'--is not on file.</p>\n";

			$p_id = create_record($dbc, 'record_of_person', $searchterms ); // trouble in here

			echo "<p>ID of new record is <b>$p_id</b>.</p>\n";
		}

		$manifest_terms[$sql_field] = $p_id;

	}

	var_dump($manifest_terms);// we have successfully linked persona's id to SQL field.

	echo "<p><a href='http://localhost/p2/$user_form'>Back to entry form</a></p>\n";

	exit("<p class = 'ghost'>Stop here for now</p>\n");


	// ====================== Places ======================

	$locale  = array('sailed_from', 'passenger_previous_residence', 'relative_at_previous_residence', 'passenger_destination','person_at_destination', 'passenger_birth');

	foreach($locale as $of_interest){

		$searchterms = array(
		 'country' => !empty($_POST['place'][$of_interest]['country']) ? $_POST['place'][$of_interest]['country'] : NULL,
		 'state' => !empty($_POST['place'][$of_interest]['state']) ? $_POST['place'][$of_interest]['state'] : NULL,
		 'city' => !empty($_POST['place'][$of_interest]['city']) ? $_POST['place'][$of_interest]['city'] : NULL,
		 'address' => !empty($_POST['place'][$of_interest]['address']) ? $_POST['place'][$of_interest]['address'] : NULL,
		 );

		var_dump($searchterms);


		echo"<p class = 'ghost'>Place <b>$of_interest</b> is:<br />
		[aka Search terms are] <br />
		 '$searchterms[address]',<br />
		 '$searchterms[city]',<br />
		 '$searchterms[state]',<br />
		 '$searchterms[country]'.
		 </p>\n";

		if($pl_id = lookup_id($dbc, 'place', 'id_place', $searchterms)){

			echo"<p>Id of place of <span class='bold'>$of_interest</span>--'$searchterms[address]', '$searchterms[city]', '$searchterms[state]', '$searchterms[country]'--is $pl_id.</p>\n";

		} else {

			echo"<p>The place of <span class='bold'>$of_interest</span>--'$searchterms[address]', '$searchterms[city]', '$searchterms[state]', '$searchterms[country]'--is not on-file.</p>\n";
			$pl_id = create_record($dbc, 'place', $searchterms );
			echo "<p>ID of new record is $pl_id.</p>\n";
		}

		// alternate, compact form!!
		// if(!$pl_id = lookup_id($dbc, $tbl, $id, $searchterms)){
		// 	$pl_id = create_record($dbc, $tbl, $searchterms );
		// }
	}


	// ====================== Vessel ID on-file?  ======================


		$searchterms = array('id_vessel' => !empty($_POST['id_vessel']) ? $_POST['id_vessel'] : NULL);

		var_dump($searchterms);

		echo "<p class = 'ghost'>Search term is '{$searchterms['id_vessel']}'.</p>\n";

		if($v_id = lookup_id($dbc, 'vessel', 'id_vessel', $searchterms)){

			echo"<p><span class='bold'>'Vessel'</span> ID '$v_id' is on file.</p>\n";

		} else {

			echo"<p><span class='bold'>'Vessel'</span>--'{$searchterms['id_vessel']}'--is not on file.</p>\n";
			$v_id = create_record($dbc, 'vessel', $searchterms );
			echo "<p>ID of new record is <b>$v_id</b>.</p>\n";
		}


	// =========== write manifest entry to disk ==========

	// need to straighten-out the multiple persons, places issue! As well as hook up other fields to record to write.

	$searchterms = array('id_passenger' => $p_id, 'id_relative_back_home' => $p_id, 'id_vessel' => $v_id);

	var_dump($searchterms);

	$m_id = create_record($dbc, 'manifest', $searchterms );

	//(`m_id`,	`vessel_name`,	`id_vessel`,	`sailed_from`,	`id_place_sailed_from`,	`date_departed`,	`date_arrived`,	`list`,	`line`,	`pass_lname`,	`pass_fname`,	`id_passenger`,	`pass_age`,	`pass_sex`,	`pass_marrital_status`,	`pass_occupation`,	`pass_can_read`,	`pass_can_write`,	`pass_nationality`,	`pass_race`,	`pass_prev_place_country`,	`pass_prev_place_state`,	`pass_prev_place_city`,	`id_pass_prev_place`,	`pass_prev_place_num_years`,	`rel_prev_place_lname`,	`rel_prev_place_fname`,	`id_rel_prev_place_person`,	`rel_prev_place_relationship`,	`rel_prev_place_country`,	`rel_prev_place_state`,	`rel_prev_place_city`,	`id_rel_prev_place_place`,	`pass_dest_state`,	`pass_dest_city`,	`id_pass_dest_place`,	`pass_prev_visit`,	`pass_prev_visit_date`,	`pass_prev_visit_length`,	`pass_prev_visit_state`,	`pass_prev_visit_city`,	`id_pass_prev_visit_place`,	`dest_person_lname`,	`dest_person_fname`,	`id_dest_person`,	`dest_person_state`,	`dest_person_city`,	`dest_person_address`,	`id_dest_person_place`,	`dest_person_relationship`,	`pass_height`,	`pass_complexion`,	`pass_hair`,	`pass_eye`,	`pass_identifying_marks`,	`pass_bth_country`,	`pass_bth_state`,	`pass_bth_city`,	`id_pass_bth_place`,	`notes`) VALUES


	echo "<p>M_id = $m_id</p>";


	// ====================== Time to go ======================

	unset($searchterms); // clean up after our selves

	//close connection 
	mysqli_close($dbc);

	echo"<p><a href='http://localhost/p2/$user_form'>Back to passenger data entry form</a></p>";

	?>

	<button type="button" onclick="hide()">Hide <span class="red">Diagnostic</span> Info</button>
	<button type="button" onclick="show()">Show <span class="red">Diagnostic</span> Info</button>

</html>