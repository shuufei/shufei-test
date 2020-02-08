import React from 'react';
import { useDispatch } from 'react-redux';

import { actionCreator } from '../../redux/reducers/index';
import TodoItem, { Props } from './TodoItem';

const View: React.FC<Omit<Props, 'onToggle'>> = function(props) {
  const dispatch = useDispatch();
  return (
    <TodoItem {...props} onToggle={(id) => dispatch(actionCreator.todos.toggleTodo({id}))}></TodoItem>
  );
}

export default View;
