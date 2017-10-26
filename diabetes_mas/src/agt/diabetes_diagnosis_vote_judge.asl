// Agent diabetes_diagnosis_vote_judge in project diabetes_mas

/* Initial beliefs and rules */
number_of_voters(0).

/* Initial goals */
!configure_vote_session.

/* Plans */
+!configure_vote_session <-
!create_diagnosis_depository;
!create_measure_communication_medium;
.broadcast(tell,start_vote_registration);
.wait(1000);
+vote_session_started
.println("start vote session");
!start_patient_dataset_reader.

+!create_diagnosis_depository <-
makeArtifact(diagnosis_result_depository,
"diabetes_mas.DiagnosisResultDepository", [], ArtId);
focus(ArtId).

+!create_measure_communication_medium : true <-
makeArtifact(measure_comm_medium,"diabetes_mas.MeasuresCommunicationMe
dium",[],MediumId)
?tuple_reader_agent(TupleReaderAgent)
.send(TupleReaderAgent,achieve,focus(measure_comm_medium)).


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have a agent that always complies with its organization  
{ include("$jacamoJar/templates/org-obedient.asl") }
