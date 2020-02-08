import React from 'react';
import styled from 'styled-components';
import TodoItem from './TodoItemContainer';
import { Todo } from '../../redux/reducers/todos';

type Props = {
  className?: string;
  todos: Todo[];
};

const View: React.FC<Props> = function({className, todos}) {
  return (
    <ul className={className}>
      {todos.map(todo => <TodoItem key={todo.id} id={todo.id} isDone={todo.completed}>{todo.text}</TodoItem>)}
    </ul>
  );
};

export default styled(View)`
  margin: 0;
  padding: 0;
  list-style: none;
  > li {
    margin-bottom: 12px;
  }
`;
