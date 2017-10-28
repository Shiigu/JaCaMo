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
makeArtifact(diagnosis_result_depository, "diabetes_mas.DiagnosisResultDepository", [], ArtId);
focus(ArtId).

+!create_measure_communication_medium : true <-
makeArtifact(measure_comm_medium,"diabetes_mas.MeasuresCommunicationMedium",[],MediumId)

?tuple_reader_agent(TupleReaderAgent)
.send(TupleReaderAgent,achieve,focus(measure_comm_medium)).


+new_voter_registration[source(VoterAgent)] <-
?number_of_voters(PreviousNumberOfVoters);
+number_of_voters(PreviousNumberOfVoters + 1);
.println("Voter number ", PreviousNumberOfVoters + 1, " registered.");
?mentor(MentorAgent)
.send(VoterAgent, tell, mentor(MentorAgent))
.send(VoterAgent, achieve, focus(diagnosis_result_depository))
.send(VoterAgent, achieve, focus(measure_comm_medium)).

+!start_patient_dataset_reader: tuple_reader_agent(TupleReaderAgent) <-
.send(TupleReaderAgent,achieve,start_patient_data_reader).

+!read_next_patient_dataset_tuple: tuple_reader_agent(TupleReaderAgent) <-
.send(TupleReaderAgent,achieve,read_next_patient_data_tuple).

+number_of_votes(CurrentNumberOfVotes) : vote_session_started & number_of_voters(NumberOfVoters) & CurrentNumberOfVotes < NumberOfVoters <-
//Bueno si, si...para el ojo común, este plan no hace nada útil pero para el ojo penetrante es un plan necesario para que el proyecto funcione como es debido.
?number_of_voters(PreviousNumberOfVoters).

+number_of_votes(CurrentNumberOfVotes) : vote_session_started & number_of_voters(NumberOfVoters) & CurrentNumberOfVotes == NumberOfVoters <-
getVotationResults(TupleNumber,PositiveVotes,NegativeVotes)
.println("Given ",NumberOfVoters," voters and ",CurrentNumberOfVotes," votes for the tuple ",TupleNumber,": Positive votes: ",PositiveVotes," Negative votes: ",NegativeVotes)
!read_next_patient_dataset_tuple.

+no_tuples_to_read <-
.println("Votation session ended").

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have a agent that always complies with its organization  
{ include("$jacamoJar/templates/org-obedient.asl") }
