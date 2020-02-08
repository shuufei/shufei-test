import React from 'react';
import { useDispatch } from 'react-redux';

import { actionCreator } from '../../redux/reducers/index';
import AddTodoForm from './AddTodoForm';

const View: React.FC<{}> = function() {
  const dispatch = useDispatch();
  return (
    <AddTodoForm onSubmit={(text) => dispatch(actionCreator.todos.addTodo({text}))}></AddTodoForm>
  );
};

export default View;