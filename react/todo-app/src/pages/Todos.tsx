import React from 'react';
import styled from 'styled-components';
import TodoList from './components/TodoList';
import AddTodoForm from './components/AddTodoFormContainer';
import * as Reducer from './Reducer';
import { useSelector } from 'react-redux';
import { RootState } from '../redux/reducers';

export type Props = {
  className?: string;
}

export const TodosDispatch: React.Context<React.Dispatch<Reducer.Action>> = React.createContext((v: Reducer.Action) => {});


const View: React.FC<Props> = function({ className }) {

  const unDoneTasks = useSelector((state: RootState) => state.todos.todos.filter(v => !v.completed));
  const doneTasks = useSelector((state: RootState) => state.todos.todos.filter(v => v.completed));

  return (
      <div className={className}>
        <AddTodoForm></AddTodoForm>

        <div className="todo-list-wrapper">
          <div className="todo-list">
            <h2>Tasks</h2>
            <TodoList todos={unDoneTasks}></TodoList>
          </div>
          <div className="todo-list">
            <h2>Done</h2>
            <TodoList todos={doneTasks}></TodoList>
          </div>
        </div>

      </div>
  );
};

export default styled(View)`
  padding: 16px 24px;
  > .todo-list-wrapper {
    display: flex;
    justify-content: center;
    > .todo-list {
      flex: 1;
      margin: 0 16px;
    }
  }
`;
