#include "CompilerParser.h"


/**
 * Constructor for the CompilerParser
 * @param tokens A linked list of tokens to be parsed
 */
CompilerParser::CompilerParser(std::list<Token*> tokens) {
    this->tokens = tokens;
    if (!this->tokens.empty()) {
        this->currentToken = this->tokens.begin();
    } else {
        // Initialize currentToken to a safe value when tokens list is empty
        this->currentToken = this->tokens.end();
    }
}


/**
 * Generates a parse tree for a single program
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileProgram() {
    // Program must start with class
    if (!have("keyword", "class")) {
        throw ParseException();
    }
    return compileClass();
}

/**
 * Generates a parse tree for a single class
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileClass() {
    ParseTree* tree = new ParseTree("class", "");
    
    Token* classToken = mustBe("keyword", "class");
    tree->addChild(new ParseTree(classToken->getType(), classToken->getValue()));
    
    // Keep the actual identifier value
    Token* className = mustBe("identifier", "");
    tree->addChild(new ParseTree(className->getType(), className->getValue()));
    
    Token* openBrace = mustBe("symbol", "{");
    tree->addChild(new ParseTree(openBrace->getType(), openBrace->getValue()));
    
    while (have("keyword", "static") || have("keyword", "field")) {
        tree->addChild(compileClassVarDec());
    }
    
    while (have("keyword", "constructor") || 
           have("keyword", "function") || 
           have("keyword", "method")) {
        tree->addChild(compileSubroutine());
    }
    
    Token* closeBrace = mustBe("symbol", "}");
    tree->addChild(new ParseTree(closeBrace->getType(), closeBrace->getValue()));
    return tree;
}

/**
 * Generates a parse tree for a static variable declaration or field declaration
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileClassVarDec() {
    ParseTree* tree = new ParseTree("classVarDec", "");
    
    // static | field
    Token* varType = mustBe("keyword", "");
    tree->addChild(new ParseTree(varType->getType(), varType->getValue()));
    
    // type
    Token* dataType;
    if (have("keyword", "")) {
        dataType = mustBe("keyword", "");
    } else {
        dataType = mustBe("identifier", "");
    }
    tree->addChild(new ParseTree(dataType->getType(), dataType->getValue()));
    
    // varName with actual value
    Token* varName = mustBe("identifier", "");
    tree->addChild(new ParseTree(varName->getType(), varName->getValue()));
    
    while (have("symbol", ",")) {
        Token* comma = mustBe("symbol", ",");
        tree->addChild(new ParseTree(comma->getType(), comma->getValue()));
        
        Token* additionalVar = mustBe("identifier", "");
        tree->addChild(new ParseTree(additionalVar->getType(), additionalVar->getValue()));
    }
    
    Token* semicolon = mustBe("symbol", ";");
    tree->addChild(new ParseTree(semicolon->getType(), semicolon->getValue()));
    return tree;
}

/**
 * Generates a parse tree for a method, function, or constructor
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileSubroutine() {
    ParseTree* tree = new ParseTree("subroutine", "");
    
    // constructor | function | method
    Token* subroutineType = mustBe("keyword", "");
    tree->addChild(new ParseTree(subroutineType->getType(), subroutineType->getValue()));
    
    // void | type
    Token* returnType;
    if (have("keyword", "void")) {
        returnType = mustBe("keyword", "void");
    } else if (have("keyword", "")) {
        returnType = mustBe("keyword", "");
    } else {
        returnType = mustBe("identifier", "");
    }
    tree->addChild(new ParseTree(returnType->getType(), returnType->getValue()));
    
    // subroutineName
    tree->addChild(new ParseTree(mustBe("identifier", "")->getType(), "identifier"));
    
    // (
    tree->addChild(new ParseTree(mustBe("symbol", "(")->getType(), "("));
    
    // parameterList
    tree->addChild(compileParameterList());
    
    // )
    tree->addChild(new ParseTree(mustBe("symbol", ")")->getType(), ")"));
    
    // subroutineBody
    tree->addChild(compileSubroutineBody());
    
    return tree;
}


/**
 * Generates a parse tree for a subroutine's parameters
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileParameterList() {
    ParseTree* tree = new ParseTree("parameterList", "");
    
    if (!have("symbol", ")")) {
        // type
        Token* paramType;
        if (have("keyword", "")) {
            paramType = mustBe("keyword", "");
        } else {
            paramType = mustBe("identifier", "");
        }
        tree->addChild(new ParseTree(paramType->getType(), paramType->getValue()));
        
        // varName
        tree->addChild(new ParseTree(mustBe("identifier", "")->getType(), "identifier"));
        
        // (',' type varName)*
        while (have("symbol", ",")) {
            tree->addChild(new ParseTree(mustBe("symbol", ",")->getType(), ","));
            
            if (have("keyword", "")) {
                paramType = mustBe("keyword", "");
            } else {
                paramType = mustBe("identifier", "");
            }
            tree->addChild(new ParseTree(paramType->getType(), paramType->getValue()));
            
            tree->addChild(new ParseTree(mustBe("identifier", "")->getType(), "identifier"));
        }
    }
    
    return tree;
}

/**
 * Generates a parse tree for a subroutine's body
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileSubroutineBody() {
    ParseTree* tree = new ParseTree("subroutineBody", "");
    
    // {
    tree->addChild(new ParseTree(mustBe("symbol", "{")->getType(), "{"));
    
    // varDec*
    while (have("keyword", "var")) {
        tree->addChild(compileVarDec());
    }
    
    // statements
    tree->addChild(compileStatements());
    
    // }
    tree->addChild(new ParseTree(mustBe("symbol", "}")->getType(), "}"));
    return tree;
}

/**
 * Generates a parse tree for a subroutine variable declaration
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileVarDec() {
    ParseTree* tree = new ParseTree("varDec", "");
    
    // var
    tree->addChild(new ParseTree(mustBe("keyword", "var")->getType(), "var"));
    
    // type
    Token* varType;
    if (have("keyword", "")) {
        varType = mustBe("keyword", "");
    } else {
        varType = mustBe("identifier", "");
    }
    tree->addChild(new ParseTree(varType->getType(), varType->getValue()));
    
    // varName
    tree->addChild(new ParseTree(mustBe("identifier", "")->getType(), "identifier"));
    
    // (',' varName)*
    while (have("symbol", ",")) {
        tree->addChild(new ParseTree(mustBe("symbol", ",")->getType(), ","));
        tree->addChild(new ParseTree(mustBe("identifier", "")->getType(), "identifier"));
    }
    
    // ;
    tree->addChild(new ParseTree(mustBe("symbol", ";")->getType(), ";"));
    return tree;
}

/**
 * Generates a parse tree for a series of statements
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileStatements() {
    ParseTree* tree = new ParseTree("statements", "");
    
    // Keep processing statements until we hit a closing brace or end of input
    while (current() != nullptr && !have("symbol", "}")) {
        if (have("keyword", "let")) {
            tree->addChild(compileLet());
        }
        else if (have("keyword", "if")) {
            tree->addChild(compileIf());
        }
        else if (have("keyword", "while")) {
            tree->addChild(compileWhile());
        }
        else if (have("keyword", "do")) {
            tree->addChild(compileDo());
        }
        else if (have("keyword", "return")) {
            tree->addChild(compileReturn());
        }
        else {
            throw ParseException();
        }
    }
    
    return tree;
}

/**
 * Generates a parse tree for a let statement
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileLet() {
    ParseTree* tree = new ParseTree("letStatement", "");
    
    // let
    tree->addChild(new ParseTree(mustBe("keyword", "let")->getType(), "let"));
    
    // varName
    tree->addChild(new ParseTree(mustBe("identifier", "")->getType(), "identifier"));
    
    // Check for array index
    if (have("symbol", "[")) {
        tree->addChild(new ParseTree(mustBe("symbol", "[")->getType(), "["));
        tree->addChild(compileExpression());
        tree->addChild(new ParseTree(mustBe("symbol", "]")->getType(), "]"));
    }
    
    // =
    tree->addChild(new ParseTree(mustBe("symbol", "=")->getType(), "="));
    
    // expression
    tree->addChild(compileExpression());
    
    // ;
    tree->addChild(new ParseTree(mustBe("symbol", ";")->getType(), ";"));
    
    return tree;
}

/**
 * Generates a parse tree for an if statement
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileIf() {
    ParseTree* tree = new ParseTree("ifStatement", "");
    
    // if
    tree->addChild(new ParseTree(mustBe("keyword", "if")->getType(), "if"));
    
    // (
    tree->addChild(new ParseTree(mustBe("symbol", "(")->getType(), "("));
    
    // expression
    tree->addChild(compileExpression());
    
    // )
    tree->addChild(new ParseTree(mustBe("symbol", ")")->getType(), ")"));
    
    // {
    tree->addChild(new ParseTree(mustBe("symbol", "{")->getType(), "{"));
    
    // statements
    tree->addChild(compileStatements());
    
    // }
    tree->addChild(new ParseTree(mustBe("symbol", "}")->getType(), "}"));
    
    // else clause (optional)
    if (have("keyword", "else")) {
        tree->addChild(new ParseTree(mustBe("keyword", "else")->getType(), "else"));
        tree->addChild(new ParseTree(mustBe("symbol", "{")->getType(), "{"));
        tree->addChild(compileStatements());
        tree->addChild(new ParseTree(mustBe("symbol", "}")->getType(), "}"));
    }
    
    return tree;
}

/**
 * Generates a parse tree for a while statement
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileWhile() {
    ParseTree* tree = new ParseTree("whileStatement", "");
    
    // while
    tree->addChild(new ParseTree(mustBe("keyword", "while")->getType(), "while"));
    
    // (
    tree->addChild(new ParseTree(mustBe("symbol", "(")->getType(), "("));
    
    // expression
    tree->addChild(compileExpression());
    
    // )
    tree->addChild(new ParseTree(mustBe("symbol", ")")->getType(), ")"));
    
    // {
    tree->addChild(new ParseTree(mustBe("symbol", "{")->getType(), "{"));
    
    // statements
    tree->addChild(compileStatements());
    
    // }
    tree->addChild(new ParseTree(mustBe("symbol", "}")->getType(), "}"));
    
    return tree;
}

/**
 * Generates a parse tree for a do statement
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileDo() {
    ParseTree* tree = new ParseTree("doStatement", "");
    
    // do
    tree->addChild(new ParseTree(mustBe("keyword", "do")->getType(), "do"));
    
    // expression (subroutine call)
    tree->addChild(compileExpression());
    
    // ;
    tree->addChild(new ParseTree(mustBe("symbol", ";")->getType(), ";"));
    
    return tree;
}

/**
 * Generates a parse tree for a return statement
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileReturn() {
    ParseTree* tree = new ParseTree("returnStatement", "");
    
    // return
    tree->addChild(new ParseTree(mustBe("keyword", "return")->getType(), "return"));
    
    // expression (optional)
    if (!have("symbol", ";")) {
        tree->addChild(compileExpression());
    }
    
    // ;
    tree->addChild(new ParseTree(mustBe("symbol", ";")->getType(), ";"));
    
    return tree;
}

/**
 * Generates a parse tree for an expression
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileExpression() {
    ParseTree* tree = new ParseTree("expression", "");
    
    // Handle special case for 'skip' keyword
    if (have("keyword", "skip")) {
        tree->addChild(new ParseTree(mustBe("keyword", "skip")->getType(), "skip"));
        return tree;
    }
    
    // First term
    tree->addChild(compileTerm());
    
    // (op term)*
    while (current() != nullptr && have("symbol", "")) {
        std::string opValue = current()->getValue();
        if (opValue == "+" || opValue == "-" || opValue == "*" || opValue == "/" || 
            opValue == "&" || opValue == "|" || opValue == "<" || opValue == ">" || 
            opValue == "=") {
            // Add operator
            tree->addChild(new ParseTree(mustBe("symbol", "")->getType(), opValue));
            // Add next term
            tree->addChild(compileTerm());
        } else {
            break;
        }
    }
    
    return tree;
}

/**
 * Generates a parse tree for an expression term
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileTerm() {
    ParseTree* tree = new ParseTree("term", "");
    
    Token* curr = current();
    if (!curr) {
        throw ParseException();
    }
    
    // Handle different types of terms
    if (have("integerConstant", "")) {
        // Integer constant
        tree->addChild(new ParseTree(mustBe("integerConstant", "")->getType(), curr->getValue()));
    }
    else if (have("stringConstant", "")) {
        // String constant
        tree->addChild(new ParseTree(mustBe("stringConstant", "")->getType(), curr->getValue()));
    }
    else if (have("keyword", "true") || have("keyword", "false") || 
             have("keyword", "null") || have("keyword", "this")) {
        // Keyword constant
        tree->addChild(new ParseTree(mustBe("keyword", "")->getType(), curr->getValue()));
    }
    else if (have("symbol", "(")) {
        // Parenthesized expression
        tree->addChild(new ParseTree(mustBe("symbol", "(")->getType(), "("));
        tree->addChild(compileExpression());
        tree->addChild(new ParseTree(mustBe("symbol", ")")->getType(), ")"));
    }
    else if (have("symbol", "-") || have("symbol", "~")) {
        // Unary operator
        tree->addChild(new ParseTree(mustBe("symbol", "")->getType(), curr->getValue()));
        tree->addChild(compileTerm());
    }
    else if (have("identifier", "")) {
        // Variable or subroutine call
        tree->addChild(new ParseTree(mustBe("identifier", "")->getType(), curr->getValue()));
        
        // Check for array access
        if (have("symbol", "[")) {
            tree->addChild(new ParseTree(mustBe("symbol", "[")->getType(), "["));
            tree->addChild(compileExpression());
            tree->addChild(new ParseTree(mustBe("symbol", "]")->getType(), "]"));
        }
        // Check for subroutine call
        else if (have("symbol", "(") || have("symbol", ".")) {
            if (have("symbol", ".")) {
                tree->addChild(new ParseTree(mustBe("symbol", ".")->getType(), "."));
                tree->addChild(new ParseTree(mustBe("identifier", "")->getType(), "identifier"));
            }
            tree->addChild(new ParseTree(mustBe("symbol", "(")->getType(), "("));
            tree->addChild(compileExpressionList());
            tree->addChild(new ParseTree(mustBe("symbol", ")")->getType(), ")"));
        }
    }
    else {
        throw ParseException();
    }
    
    return tree;
}

/**
 * Generates a parse tree for an expression list
 * @return a ParseTree
 */
ParseTree* CompilerParser::compileExpressionList() {
    ParseTree* tree = new ParseTree("expressionList", "");
    
    // Check if the expression list is not empty
    if (!have("symbol", ")")) {
        // First expression
        tree->addChild(compileExpression());
        
        // (',' expression)*
        while (have("symbol", ",")) {
            tree->addChild(new ParseTree(mustBe("symbol", ",")->getType(), ","));
            tree->addChild(compileExpression());
        }
    }
    
    return tree;
}

/**
 * Advance to the next token
 */
void CompilerParser::next() {
    if (currentToken != tokens.end()) {
        ++currentToken;
    }
}

/**
 * Return the current token
 * @return the Token
 */
Token* CompilerParser::current() {
    if (currentToken != tokens.end()) {
        return *currentToken;
    }
    return nullptr;
}

/**
 * Check if the current token matches the expected type and value.
 * @return true if a match, false otherwise
 */
bool CompilerParser::have(std::string expectedType, std::string expectedValue) {
    Token* curr = current();
    if (!curr) return false;
    
    if (expectedValue == "") {
        return curr->getType() == expectedType;
    }
    return curr->getType() == expectedType && curr->getValue() == expectedValue;
}

/**
 * Check if the current token matches the expected type and value.
 * If so, advance to the next token, returning the current token, otherwise throw a ParseException.
 * @return the current token before advancing
 */
Token* CompilerParser::mustBe(std::string expectedType, std::string expectedValue) {
    if (!have(expectedType, expectedValue)) {
        throw ParseException();
    }
    Token* token = current();
    next();
    return token;
}

/**
 * Definition of a ParseException
 * You can use this ParseException with `throw ParseException();`
 */
const char* ParseException::what() {
    return "An Exception occurred while parsing!";
}