// Internal action code for project diabetes_mas

package jia;

import classifiers.TreeClassifier;
import jason.JasonException;
import jason.asSemantics.DefaultInternalAction;
import jason.asSemantics.TransitionSystem;
import jason.asSemantics.Unifier;
import jason.asSyntax.LiteralImpl;
import jason.asSyntax.StringTerm;
import jason.asSyntax.StringTermImpl;
import jason.asSyntax.Term;
import utils.JasonUtils;

public class classifyDecisionTreeDiabetesDiagnosis extends DefaultInternalAction {

	private static final long serialVersionUID = 1679672878186078747L;

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
    	
    	double [] patientDataTuple = JasonUtils.getDoubleArrayfrom(args[1]);
    	
    	String result = classifier.ClassifyInstance(patientDataTuple); 
    	Term resultTerm = new LiteralImpl(result.toUpperCase());
    	
        return un.unifies(resultTerm,args[2]);
    }
}
