import React from 'react';
import styled from 'styled-components';

import { colors } from '../../style-variables';
import { Todo } from '../../redux/reducers/todos';

export type Props = {
  className?: string;
  isDone: Todo['completed'];
  id: Todo['id'];
  onToggle: (id: Todo['id']) => void;
};

const View: React.FC<Props> = function({className, children, isDone, id, onToggle}) {

  function toggle() {
    // isDone ? dispatch({ type: 'undone', payload: id }) : dispatch({ type: 'done', payload: id });
    onToggle(id);
  }

  return (
    <li className={className}>
      <label>
        <input type="checkbox" checked={isDone} onChange={toggle} />
        <span className={isDone ? 'is-done' : ''}>{children}</span>
      </label>
    </li>
  );
}

export default styled(View)`
  padding: 8px 12px;
  background: ${colors.gray50};
  border-radius: 3px;
  box-shadow: 0 3px 5px rgba(0,0,0,0.13);
  cursor: pointer;
  transition: 0.15s ease-out;
  > label {
    cursor: pointer;
    > span {
      display: inline-block;
      margin-left: 4px;
    }
    > .is-done {
      text-decoration: line-through;
    }
  }
`;
