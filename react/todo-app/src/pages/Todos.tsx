import React, { useReducer } from 'react';
import styled from 'styled-components';
import TodoList from './components/TodoList';
import { Todo } from './components/TodoItem';
import AddTodoForm from './components/AddTodoForm';
import * as Reducer from './Reducer';

type Props = {
  className?: string;
}

export const TodosDispatch: React.Context<React.Dispatch<Reducer.Action>> = React.createContext((v: Reducer.Action) => {});


const View: React.FC<Props> = function({ className }) {

  const [state, dispatch] = useReducer(Reducer.reducer, Reducer.initialState);

  const unDoneTasks: Todo[] = state.todos.filter(v => !v.isDone);
  const doneTasks: Todo[] = state.todos.filter(v => v.isDone);

  return (
    <TodosDispatch.Provider value={dispatch}>
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
    </TodosDispatch.Provider>
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
