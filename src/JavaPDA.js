import React from 'react';
import Code from './Code';

const JavaPDA= (props) => {
    const title = props.title || "Autômato identificador de enums";
    return <Code
        title={title}
        code={require('!raw-loader!./code/java.pda')}
        showNumbers={false}
        dark={true}
        steps={props.steps}
    />
}

export default JavaPDA;