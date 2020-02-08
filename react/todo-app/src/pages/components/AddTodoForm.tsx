import React, { useState } from 'react';
import styled from 'styled-components';
import { colors } from '../../style-variables';

export type Props = {
  className?: string;
  onSubmit: (text: string) => void;
};

const View: React.FC<Props> = function({className, onSubmit}) {

  const [text, setText] = useState('');

  return (
    <div className={className}>
      <input type="text" value={text} onChange={(e) => setText(e.target.value)} />
      <button onClick={() => { onSubmit(text); setText(''); }} disabled={text === ''}>Add</button>
    </div>
  );
};

export default styled(View)`
  display: flex;
  align-items: center;
  justify-content: center;
  > input {
    border: solid 1px #ccc;
    border-radius: 3px;
    padding: 6px 8px;
  }
  > button {
    margin-left: 8px;
    background-color: ${colors.blue};
    color: #fff;
    padding: 6px 8px;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    &:disabled {
      background-color: ${colors.gray300};
      cursor: unset;
    }
  }
`;
