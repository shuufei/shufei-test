import React from 'react';
import styled from 'styled-components';
import TodoItem, { Todo } from './TodoItem';

type Props = {
  className?: string;
  todos: Todo[];
};

const View: React.FC<Props> = function({className, todos}) {
  return (
    <ul className={className}>
      {todos.map(todo => <TodoItem key={todo.id} id={todo.id} isDone={todo.isDone}>{todo.title}</TodoItem>)}
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
