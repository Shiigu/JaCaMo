/* Initial beliefs and rules */

/* Initial goals */
!configure_my_result_artefact.

/* Plans */
+!configure_my_result_artefact <-
makeArtifact(doctor_result_artefact, "diabetes_mas.DoctorResultArtefact", [], ArtId);
focus(ArtId).

+partial_diagnosis_result (PatientTupleNumber,PositiveCases,NegativeCases) <-
.println("For tuple ", PatientTupleNumber, ": ", PositiveCases, " Positive and ", NegativeCases, " Negative");
addPartialDiagnosisResult(PositiveCases,NegativeCases).

+!final_report <-
buildFinalReport(FinalReport);
.println(FinalReport).


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
