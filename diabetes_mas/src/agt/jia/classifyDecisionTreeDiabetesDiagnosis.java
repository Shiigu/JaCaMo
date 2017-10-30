// Internal action code for project diabetes_mas

package jia;

import java.util.Arrays;

import classifiers.TreeClassifier;
import jason.JasonException;
import jason.asSemantics.DefaultInternalAction;
import jason.asSemantics.TransitionSystem;
import jason.asSemantics.Unifier;
import jason.asSyntax.Literal;
import jason.asSyntax.LiteralImpl;
import jason.asSyntax.StringTerm;
import jason.asSyntax.StringTermImpl;
import jason.asSyntax.Term;
import jason.asSyntax.UnnamedVar;
import model.DiabetesDiagnosisResultEnum;
import utils.JasonUtils;

public class classifyDecisionTreeDiabetesDiagnosis extends DefaultInternalAction {

    @Override
    public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception {
    	
    	if (args[0].isString() == false ){
    		throw new JasonException("first argument is not a string");
    	}
    	
    	StringTerm modelPath = (StringTermImpl) args[0];
    	
    	TreeClassifier classifier = new TreeClassifier(modelPath.getString());
    	
    	if (args[1].isList() == false) {
    		throw new JasonException("second argument is not a list");
    	}

    	double [] completePatientDataTuple = JasonUtils.getDoubleArrayfrom(args[1]);
    	/*
    	 * args[1] should contain just this-tuple values, but it contains the values from the beginning up to this tuple.
    	 */
    	double[] patientDataTupleLastEightElements = getLastElements(8, completePatientDataTuple);
    	
    	String result = classifier.ClassifyInstance(patientDataTupleLastEightElements); 
    	Term resultTerm = new LiteralImpl(result.toUpperCase());
    	
        return un.unifies(resultTerm,args[2]);
    }

    /**
     * Given an array of double, it returns the last <code>numberOfElements</code> of the array
     *
     * @param numberOfElements number of elements to return
     * @param originalArray original array
     * @return a <code>double</code> array with the last <code>numberOfElements</code>
     * of the provided array
     */
	public static double[] getLastElements(int numberOfElements, double[] originalArray) {
		double[] arrayToReturn = new double[numberOfElements];
    	int lastIdx = originalArray.length - 1;
    	for (int i = 0 ; i < numberOfElements ; i++) {
    		arrayToReturn[7 - i] = originalArray[lastIdx - i];
    	}
		return arrayToReturn;
	}
}
