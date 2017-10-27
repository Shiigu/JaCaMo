// Internal action code for project diabetes_mas

package jia;

import java.util.Date;
import java.util.Random;

import jason.asSemantics.*;
import jason.asSyntax.*;

public class determineModelPath extends DefaultInternalAction {

	private static final long serialVersionUID = -440364528866390568L;

	@Override
    public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception {

    	Random random = new Random(new Date().getTime());
    	String basePath = "models\\";    	
    	String[] treeModelNames = {"Sin_0_6","Sin_3_4","Sin_6_3_0","Sin_6_3_2"};
    	String[] neuralNetworkModelPaths = {"reptree.model_sin_0_6","reptree.model_sin_3_4",
    			"reptree.model_sin_6_3_0","reptree.model_sin_6_3_2"};
    	
    	String algType  = args[0].toString();
    	String modelPath = "";
    	
    	if (algType.equals("decision_tree") ) {
    		int normalizedPosition =  (int)(Math.abs(random.nextInt()) % treeModelNames.length);
    		modelPath = basePath + treeModelNames[normalizedPosition];
    	}
    	else {
    		int normalizedPosition =  (int)(Math.abs(random.nextInt()) % neuralNetworkModelPaths.length);
    		modelPath = basePath + neuralNetworkModelPaths[normalizedPosition];
    	}
    	
       	StringTerm strTerm = new StringTermImpl(modelPath);
       	
        // everything ok, so returns true
        return un.unifies(strTerm, args[1]);
    }
}
