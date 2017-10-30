/* Initial beliefs and rules */

/* Initial goals */
!configure_my_result_artefact.

/* Plans */
+!configure_my_result_artefact <-
makeArtifact(doctor_result_artefact, "diabetes_mas.DoctorResultArtefact", [], ArtId);
focus(ArtId).

+partial_diagnosis_result (PatientTupleNumber,PositiveCases,NegativeCases) <-
addPartialDiagnosisResult(PositiveCases,NegativeCases).

+!final_report <-

buildFinalReport(FinalReport);
.println(FinalReport).


//send(Mentor, askHow, { +!perform_diabetes_diagnosis(PatientMeasure)}, Plan);

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have a agent that always complies with its organization  
{ include("$jacamoJar/templates/org-obedient.asl") }
