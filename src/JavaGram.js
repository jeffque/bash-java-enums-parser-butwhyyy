import React from 'react';
import Code from './Code';

const JavaGram = (props) => {
    const title = props.title || "Gramática Java (simplificada)";
    return <Code
        title={title}
        code={require('!raw-loader!./code/java.bnf')}
        showNumbers={false}
        dark={true}
        steps={props.steps}
    />
}

export default JavaGram;